# -*- encoding : utf-8 -*-
include DataHoraHelper
class OrdemServico < ActiveRecord::Base

	TREINAMENTO = 0
	SUPORTE = 1
	INSTALACAO = 2
	DESENVOLVIMENTO = 3
	OUTROS = 9
	TIPOS = {	
		"Treinamento" 		=> TREINAMENTO, 
		"Suporte" 			=> SUPORTE, 
 	 	"Instalação"  		=> INSTALACAO,
 	 	"Desenvolvimento" 	=> DESENVOLVIMENTO,
 	 	"Outros" 			=> OUTROS 
 	}

	EXECUCAO_INTERNA = 0
	EXECUCAO_EXTERNA = 1
	LOCAIS_EXECUCAO = {
		"Interna" => EXECUCAO_INTERNA, 
		"Externa" => EXECUCAO_EXTERNA
	}

	TARIFACAO_TABELA = 0
	TARIFACAO_ORCAMENTO = 1
	TIPOS_TARIFACAO = {
		"Tabela"  	=> TARIFACAO_TABELA,
		"Orçamento" => TARIFACAO_ORCAMENTO,
	}

	validates :cliente_id, :presence => true
	validates :cliente_contato_id, :presence => true
	validates :usuario_responsavel_id, :presence => true
	validates :usuario_cadastrante_id, :presence => true
	validates :tipo_os, :presence => true
	validates :local_execucao, :presence => true, :numericality => true
	validates :descricao, :presence => true
	
	validates :usuarios_participantes, 
			  :presence => true, 
			  :length => {:maximum => 254}, 
			  :if => Proc.new{|o| o.tipo_os == TREINAMENTO }

	validates :data_execucao, :presence => true
	validates :hora_inicio, 
			  :presence => true, 
			  :if => Proc.new{|o| o.tipo_tarifacao == TARIFACAO_TABELA }

	validates :hora_fim, 
	          :presence => true, 
			  :if => Proc.new{|o| o.tipo_tarifacao == TARIFACAO_TABELA }

	validates :minutos_trabalhados, :presence => true, :numericality => true
	
	validates :valor_deslocamento, :numericality => true
	validates :valor_servico, 
			  :numericality => {:greater_than => 0},
			  :if => Proc.new{|o| o.tipo_os != DESENVOLVIMENTO && 
		 						o.tipo_tarifacao == TARIFACAO_ORCAMENTO }

	validates :valor_total, :presence => true, :numericality => true
	validates :minutos_desconto, :numericality => true
	validates :tipo_tarifacao, :numericality => true

	validates_associated :itens

	validate :hora_fim_menor_hora_inicio, 
			 :intervalo_maior_que_horas_trabalhadas

	belongs_to :cliente
	belongs_to :solicitante, 
			   :class_name => "ClienteContato", 
			   :foreign_key => "cliente_contato_id"

	belongs_to :responsavel, 
			   :class_name => "Usuario",
			   :foreign_key => "usuario_responsavel_id"

	belongs_to :cadastrante, 
			   :class_name => "Usuario",
			   :foreign_key => "usuario_cadastrante_id"
			   
	has_many :itens, :class_name => "OrdemServicoItem", :dependent => :destroy
	accepts_nested_attributes_for :itens, 
			:reject_if => lambda { |i| i[:solucao_sub_modulo_id].blank? }, 
			:allow_destroy => true
  	
	has_many :solicitacoes, :dependent => :nullify

	attr_accessor :horas_desconto

	def tipo_os_descricao
		TIPOS.key(self.tipo_os)
	end

	def horas_trabalhadas
		minutos_em_horas(self.minutos_trabalhados)
	end

	def horas_faturadas
		minutos_em_horas(self.minutos_faturados)
	end

	def horas_bonus_utilizado
		minutos_em_horas(self.minutos_bonus_utilizados)
	end

	def hora_inicio_formatada
		return "" if self.hora_inicio.nil?
		self.hora_inicio.to_s(:time)
	end

	def hora_fim_formatada
		return "" if self.hora_fim.nil?
		self.hora_fim.to_s(:time)
	end

	def tempo_intervalo_formatado
		return "" if self.tempo_intervalo.nil?
		self.tempo_intervalo.to_s(:time)
	end

	def data_execucao_formatada
		self.data_execucao.strftime("%d/%m/%Y")
	end

	def horas_desconto
		return "" if self.minutos_desconto == 0
		minutos_em_horas(self.minutos_desconto)
	end

	before_validation  :atribui_minutos_de_desconto,
					   :calcula_quantidade_minutos_trabalhados
					  
	before_save :atribui_valor_deslocamento,
				:credita_minutos_bonus_cliente, 
				:calcula_quantidade_minutos_faturados,
				:calcula_valor_servico, 
				:calcula_valor_total 

	after_save 	:remove_itens_senao_treinamento,
				:debita_minutos_bonus_cliente

	before_destroy :credita_minutos_bonus_cliente
	
private 
	
	#
	#validacoes
	#
	def hora_fim_menor_hora_inicio
		return if (!self.hora_inicio.present? || !self.hora_inicio.present?)
		return if self.hora_fim > self.hora_inicio
		errors.add(:hora_fim,"Deverá ser maior que a hora de início.") 
	end

	def intervalo_maior_que_horas_trabalhadas
		return if (!self.hora_inicio.present? || !self.hora_inicio.present?)
		return if (self.hora_fim - self.hora_inicio) >= total_segundos(self.tempo_intervalo)
		errors.add(:tempo_intervalo,"Intervalo maior que horas trabalhadas.") 
	end

	def remove_itens_senao_treinamento
		self.itens.each{|i| i.destroy } unless self.tipo_os == TREINAMENTO
	end

	#
	#Atribuições internas
	#
	def atribui_valor_deslocamento
		return unless self.local_execucao == EXECUCAO_EXTERNA
		self.valor_deslocamento = self.cliente.valor_deslocamento
	end

	def atribui_minutos_de_desconto
		return unless @horas_desconto.present?
		self.minutos_desconto = total_segundos(@horas_desconto)/60
	end

	#
	#Calulos para da fechamento O.S
	#
	#Calcula a quantidade de horas trabalhadas baseado na 
	#hora de inicio, fim e intervalo de descanso (hora_fim - hora_inicio - intervalo )
	def calcula_quantidade_minutos_trabalhados
		return if (!self.hora_inicio.present? || !self.hora_inicio.present?)
		segundos = self.hora_fim - self.hora_inicio
	 	segundos -= total_segundos(self.tempo_intervalo) if self.tempo_intervalo.present?
		segundos -= (self.minutos_desconto * 60) if self.minutos_desconto.present?
		self.minutos_trabalhados = segundos/60
	end


	#Calcula a quantidade de minutos que serão faturados, podera acorrer situacoes
	#em que o cliente tem bonus para serem gastos com treinamento
	def calcula_quantidade_minutos_faturados
		mb = self.cliente.minutos_bonus
		if mb > 0 && self.tipo_os == TREINAMENTO
			if mb >= self.minutos_trabalhados 
				self.minutos_faturados = 0
				self.minutos_bonus_utilizados = self.minutos_trabalhados 
			else
				self.minutos_faturados = self.minutos_trabalhados - mb
				self.minutos_bonus_utilizados = mb
			end
		else
			self.minutos_faturados = self.minutos_trabalhados
			self.minutos_bonus_utilizados = 0
		end
	end

	#Quando Treinamento, o valor da O.S nao é digitado na tela, será calculado
	#baseado no valor da hora que foi configurado no cliente X qtde de horas faturadas
	def calcula_valor_servico
		if self.tipo_tarifacao == TARIFACAO_TABELA
			valor_hora = self.cliente.valor_hora_visita
			valor_hora_minuto = valor_hora / 60 #valor da visita por minuto
			self.valor_servico = (valor_hora_minuto * self.minutos_faturados).to_f.round(2)

		elsif self.tipo_tarifacao == TARIFACAO_ORCAMENTO && self.tipo_os == DESENVOLVIMENTO 
			#recuperar valor total de cada Solicitação vinculada à O.S.
		end
	end

	def calcula_valor_total
		self.valor_total = self.valor_servico + self.valor_deslocamento
	end

	def debita_minutos_bonus_cliente
		self.cliente.debita_minutos_bonus(self.minutos_bonus_utilizados)
	end

	def credita_minutos_bonus_cliente
		return if self.new_record? || minutos_bonus_utilizados == 0
		self.cliente.credita_minutos_bonus(self.minutos_bonus_utilizados)
	end

end
