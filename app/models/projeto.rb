# -*- encoding : utf-8 -*-
include DataHoraHelper
class Projeto < ActiveRecord::Base
  
  #Status do Projeto
  ATIVO = 1
  EM_ANDAMENTO = 2
  INTERROMPIDO = 3
  CANCELADO = 4
  FINALIZADO = 5
  STATUS = ["Ativo", "Em Andamento", "Interrompido", "Cancelado","Finalizado"]

  #Frequencia de visitas
  DIARIO = 1
  SEMANAL = 7
  QUINZENAL = 15
  MENSAL = 30

  validates :nome, presence:true, length:{maximum:50}, uniqueness: {scope: :cliente_id}
  validates :cliente_id, presence:true
  validates :data_inicio, presence:true
  validates :data_prevista_termino, presence:true
  validates :status, presence:true
  validates :usuario_id, presence:true
  validates :frequencia_visita, :presence => true,
            :if => Proc.new {|p| p.etapa_ids.include?(Etapa::TREINAMENTO)}
  validates :duracao_visita_horas, :presence => true,
            :if => Proc.new {|p| p.etapa_ids.include?(Etapa::TREINAMENTO)}

  validate :previsao_termino_menor_que_data_inicio
  validate :validar_duracao_visita_horas_maior_que_zero

  belongs_to :cliente
  belongs_to :usuario
  has_many :solicitacoes
  #has_and_belongs_to_many :etapas
  has_many :etapas_projetos
  has_many :etapas, through: :etapas_projetos
  has_and_belongs_to_many :solucoes

  has_many :projetos_sub_modulos
  has_many :solucao_sub_modulos, :through => :projetos_sub_modulos

  has_many  :programacao_treinamentos, class_name: 'ProjetoProgramacaoTreinamento'

  attr_reader :peso_total
  attr_accessor :ordem, :duracao_visita_horas

  before_validation :attribui_minutos_duracao_visita
  before_save :consiste_campos_atrelados_a_etapa_treinamento 
  after_save :atualiza_ordem_etapas,:save_solucao_sub_modulos

  def peso_total
    @peso_total ||= (solicitacoes.sum(:peso) || 0)
  end

  def progresso
    return 0 if peso_total == 0
    total_concluido = 0
    self.etapas_projetos.each{|etapa| total_concluido += etapa.peso_concluido_etapa}
    resultado = total_concluido.to_f / peso_total.to_f
    return (resultado * 100).round(2)
  end

  def informacoes_sobre_criacao
    "#{created_at.strftime("%d/%m/%y")} por #{usuario.nome}"
  end

  def descricao_status
    STATUS[status - 1]
  end

  def participantes
    participantes = []
    #Participantes recuperados a partir dos históricos de movimentações das solicitacoes
    usuarios = Usuario.joins(:solicitacao_historicos => [:solicitacao => :projeto])
    usuarios = usuarios.select("usuarios.*")
    usuarios = usuarios.where("projetos.id = ?", self.id)
    usuarios.each{|u| participantes << u unless participantes.include?(u)}
    return participantes
  end

  #definicao de metodos baseado nas etapas existentes
  Etapa.all.each do |etapa|
    define_method "possui_#{etapa.contexto}?" do
      etapa_ids.include? etapa.id
    end

    define_method "solicitacoes_etapa_#{etapa.contexto}" do
      self.solicitacoes.where(etapa_id:etapa.id)
    end
  end
  
  def duracao_visita_horas
    minutos_em_horas(self.duracao_visita_minutos)
  end

  def solucao_modulo_ids
    return [] if self.new_record?
    inner_sql=<<-SQL
                id in (
                  select distinct sm.solucao_modulo_id
                  from projetos_sub_modulos psm
                  inner join solucao_sub_modulos sm on psm.solucao_sub_modulo_id = sm.id
                  where psm.projeto_id = #{self.id}
                )
              SQL
    SolucaoModulo.where(inner_sql).collect{|m| m.id}
  end

  def sub_modulos_programados_treinamento
    ids = []
    self.programacao_treinamentos.each{|p| ids << p.solucao_sub_modulo_ids}
    ids.flatten
  end
private 
  
  def save_solucao_sub_modulos
    return unless self.solucoes.any?
      subs = SolucaoSubModulo.joins(:solucao_modulo).where('solucao_modulos.solucao_id' => self.solucao_ids)
      self.solucao_sub_modulos.delete_all
      subs.each do |s| 
        ProjetosSubModulo.create(projeto_id:self.id,solucao_sub_modulo_id:s.id)
      end
  end

  def validar_duracao_visita_horas_maior_que_zero
    return if !self.etapa_ids.include?(Etapa::TREINAMENTO) 
    errors.add(:duracao_visita_horas, "Deverá ser maior que zero horas") if duracao_visita_minutos ==0
    return false
  end

  def consiste_campos_atrelados_a_etapa_treinamento
    unless self.etapa_ids.include?(Etapa::TREINAMENTO)
      self.duracao_visita_minutos = 0
      self.frequencia_visita = nil
    end
  end

  def previsao_termino_menor_que_data_inicio
  	return if data_inicio.nil? || data_prevista_termino.nil?
  	if data_inicio > data_prevista_termino
  		errors.add(:data_prevista_termino, "Data Prevista para Termino devera ser maior que a Data de Inicio.")
  	end
  end

  def atualiza_ordem_etapas
    return if self.ordem.nil?
    self.ordem.each_with_index do |e,i|
      etapa = self.etapas.where(id:e).first
      etapa.update_attributes(ordem:i)
    end
  end

  def attribui_minutos_duracao_visita
    return if @duracao_visita_horas.nil? || @duracao_visita_horas.empty?
    self.duracao_visita_minutos = total_minutos(@duracao_visita_horas)
    puts self.duracao_visita_minutos
  end
end
