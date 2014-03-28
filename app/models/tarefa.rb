# -*- encoding : utf-8 -*-
include DataHoraHelper
include ApplicationHelper
class Tarefa < ActiveRecord::Base
  
	validates :usuario_id, :presence => true
	validates :solicitacao_id, :presence => true
  validates :data_hora_inicio,:presence => true
  validates :data_hora_fim, :presence => true

  validates :nivel_complexidade, :presence => true 
  validates :peso, :presence => true 
  validates :previsao_duracao_horas, :presence => true 
  # validates :gera_cobranca, :presence => true 
  # validates :valor_cobranca, :presence => true 
  validates :data_inicio, :presence => true
  validates :hora_inicio, :presence => true

  belongs_to :usuario
  belongs_to :solicitacao

  attr_accessor :nivel_complexidade, :peso,:previsao_duracao_horas,
                :gera_cobranca,:valor_cobranca, :data_inicio,:hora_inicio #, :to => :solicitacao

  before_validation :set_data_hora_inicio, :calcular_data_hora_fim

  before_destroy :verify_if_destroyable
  after_save :atualiza_solicitacao 

  def controle
    self.id.to_s.rjust(6,'0')  
  end

  def nivel_complexidade
		@nivel_complexidade || ( self.solicitacao.nil? ? nil : self.solicitacao.nivel_complexidade)
  end

  def peso
  	@peso || ( self.solicitacao.nil? ? nil : self.solicitacao.peso)
  end

  def previsao_duracao_horas
  	@previsao_duracao_horas || ( self.solicitacao.nil? ? nil : self.solicitacao.previsao_de_duracao)
  end

  def gera_cobranca
  	@gera_cobranca || ( self.solicitacao.nil? ? nil : self.solicitacao.gera_cobranca)
  end

  def valor_cobranca
  	@valor_cobranca || (self.solicitacao.nil? ? nil : self.solicitacao.valor_cobranca)
  end

  def data_inicio
    d = (@data_inicio || (self.solicitacao.nil? ? nil : self.solicitacao.data_inicio))
    d = formata_data(d) unless d.is_a?(String)
    d
  end

  def hora_inicio
    h = (@hora_inicio || (self.solicitacao.nil? ? nil : self.solicitacao.hora_inicio))
    h = formata_hora(h) unless h.is_a?(String)
    h
  end

  def periodo_duracao
    datas = []
    data_ini = self.solicitacao.data_inicio
    unless self.data_hora_fim.nil?
      while data_ini <= self.data_hora_fim.to_date
        datas << data_ini
        data_ini += 1.day
      end       
    end
    datas
  end
private

  def set_data_hora_inicio
    return if self.data_inicio.nil? || self.hora_inicio.nil?
    d = Date.parse(self.data_inicio)
    t = Time.parse(self.hora_inicio)
    self.data_hora_inicio = DateTime.new(d.year,d.month,d.day,t.hour,t.min,t.sec)
  end

  def calcular_data_hora_fim
    return if self.data_hora_inicio.nil? || self.previsao_duracao_horas.empty?
    mins = total_minutos(self.previsao_duracao_horas)
    t = data_hora_inicio.to_datetime
    while mins > 0 do
      data_ate_18 = DateTime.new(t.year,t.month,t.day,18,0,0)
      dif_min = dif_em_minutos(t,data_ate_18)
      if dif_min > 0
        if dif_min < mins
          t = t + 1.day
          t = DateTime.new(t.year,t.month,t.day,8,0,0)
        else
          t = t + mins.minutes
        end
        mins -= dif_min
      else
        mins = 0
      end
    end
    self.data_hora_fim = t
  end

	def atualiza_solicitacao
		attributes = {
			nivel_complexidade:nivel_complexidade,
			peso:peso,
			previsao_duracao_horas:previsao_duracao_horas,
			gera_cobranca:gera_cobranca,
			valor_cobranca:valor_cobranca,
      data_inicio:data_inicio,
      hora_inicio:hora_inicio,
      previsao_duracao_horas:previsao_duracao_horas,
      status_id:Status::AG_DESENV
		}
		self.solicitacao.update_attributes(attributes)
	end

  def verify_if_destroyable
    nao permitr excluir tarefa se o ultimo status  for diferente de aguardando desenv
    nao permitr excluir tarefa se o ultimo status  for de fechamento
    se excluir a tarefa devera voltar o status da solicitacao
    self.solicitacao.
  end
end
