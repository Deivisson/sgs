# -*- encoding : utf-8 -*-
class ProjetoProgramacaoTreinamento < ActiveRecord::Base
  include DataHoraHelper

  ATIVA = 1
  CANCELADA = 2

  STATUS = {:ativa => ATIVA,:cancelada => CANCELADA}
  DESCRICAO_STATUS = ["Ativa", "Cancelada"]

  TREINAMENTO_NO_CLIENTE = 1
  TREINAMENTO_LOCAL = 2

  LOCAL_TREINAMENTO = {"Local"      => TREINAMENTO_LOCAL,
                       "No Cliente" => TREINAMENTO_NO_CLIENTE}
  DESCRICAO_LOCAL_TREINAMENTO = ["Local", "No Cliente"]

	#validates_associated :projeto, :presence => true
	validates :usuario_id, :presence => true
	validates :data_programacao, :presence => true
	validates :hora_programacao, :presence => true
	validates :participantes, :presence => true, length: {maximum: 200}
  validates :motivo_cancelamento, :presence => true, :if => Proc.new{|p| p.status == CANCELADA}
  validates :status, :presence => true
  validates :local_treinamento, :presence => true

  validate :data_programacao_valida
  validate :valid_solucao_sub_modulos
  validate :conflito_entre_agendamento_tecnico

  before_validation :calcula_previsao_termino

  belongs_to :projeto
  belongs_to :usuario
  has_and_belongs_to_many :solucao_sub_modulos,
                          :after_remove => :destroy_treinamento_if_has_no_sub_modulos

  has_one :compromisso, :dependent => :destroy

  attr_accessor :duracao_prevista, 
                :total_minutos_treinamento_sub_modulos,
                :usuario_cadastrante_id

  after_save :destroy_sub_modulos_if_canceled, 
             :gerencia_compromisso

  def controle
  	self.id.to_s.rjust(6,'0')
  end

  def total_minutos_treinamento_sub_modulos
    @total_minutos_treinamento_sub_modulos ||= SolucaoSubModulo.where(id:self.solucao_sub_modulo_ids).sum(:previsao_treinamento_minutos)
  end

  def data_hora_inicio_previsto
    return nil if data_programacao.nil? || hora_programacao.nil?
    d = data_programacao
    h = hora_programacao
    DateTime.new(d.year, d.month, d.day, h.hour, h.min, h.sec)
  end

  def duracao_prevista
    total_minutos = total_minutos_treinamento_sub_modulos
    minutos_em_horas(total_minutos)
  end

  STATUS.each do |k,v|
    define_method "#{k}?" do 
      self.status == v
    end
  end

  def descricao_status
    DESCRICAO_STATUS[self.status - 1]
  end

  def descricao_local_treinamento
    return "" if self.local_treinamento == 0
    DESCRICAO_LOCAL_TREINAMENTO[self.local_treinamento - 1]
  end

private
  
  def calcula_previsao_termino
    return if self.hora_programacao.nil?
    total_minutos = total_minutos_treinamento_sub_modulos
    self.data_previsao_termino = data_hora_inicio_previsto + total_minutos.minutes
  end

  def data_programacao_valida
    return if self.hora_programacao.nil? || !self.new_record?
    if self.data_programacao < Date.today
      errors.add(:data_programacao,"Data da Programação deverá ser maior or igual a data atual.")
    end
    if self.data_programacao < self.projeto.data_inicio
      errors.add(:data_programacao,"Data da Programação não poder ser inferior a data de início do projeto.")
    end
  end

  def valid_solucao_sub_modulos
    if self.solucao_sub_modulo_ids.empty?
      errors.add(:solucao_sub_modulo_ids,"Sub Módulos possuem seleção Obrigatório.")
    end
  end

  def conflito_entre_agendamento_tecnico
    return if self.usuario_id.nil? || self.data_previsao_termino.nil?
    p = ProjetoProgramacaoTreinamento.where("usuario_id = ? and ?
        BETWEEN TIMESTAMP(data_programacao,hora_programacao) AND data_previsao_termino",self.usuario_id,self.data_previsao_termino)
    p = p.where("id <> ?",self.id) unless self.new_record?
    p = p.where("status = ?",ATIVA)
    
    if p.any?
      errors.add(:usuario_id,"Existe conflito de horário com a agenda do Técnico.")
    end
  end

  def destroy_treinamento_if_has_no_sub_modulos(obj)
    return if self.status == CANCELADA #SE cancelada, não exlui a programacao sem sub_modulos
    self.destroy if self.solucao_sub_modulos.empty?
  end

  def destroy_sub_modulos_if_canceled
    self.solucao_sub_modulos.destroy_all if self.status == CANCELADA    
  end

  def gerencia_compromisso
    comp = self.compromisso.nil? ? self.build_compromisso : self.compromisso
    if self.status != CANCELADA
      comp.data_inicio                        = self.data_programacao
      comp.hora_inicio                        = self.hora_programacao
      comp.data_fim                           = self.data_previsao_termino.to_date
      comp.hora_fim                           = self.data_previsao_termino.to_time
      comp.usuario_id                         = self.usuario_id
      comp.descricao                          = "Agendamento de Treinamento"
      comp.usuario_cadastrante_id             = self.usuario_cadastrante_id
      comp.projeto_programacao_treinamento_id = self.id
      comp.status                             = Compromisso::ATIVO
    else
      comp.status = Compromisso::CANCELADO
    end
    puts comp.save
    puts comp.errors.full_messages
  end
end
