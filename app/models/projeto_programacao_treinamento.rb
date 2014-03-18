# -*- encoding : utf-8 -*-
class ProjetoProgramacaoTreinamento < ActiveRecord::Base
  include DataHoraHelper

	validates_associated :projeto, :presence => true
	validates :usuario_id, :presence => true
	validates :data_programacao, :presence => true
	validates :hora_programacao, :presence => true
	validates :participantes, :presence => true, length: {maximum: 200}
  
  validate :data_programacao_valida
  validate :valid_solucao_sub_modulos
  validate :conflito_entre_agendamento_tecnico

  before_validation :calcula_previsao_termino

  belongs_to :projeto
  belongs_to :usuario
  has_and_belongs_to_many :solucao_sub_modulos

  attr_accessor :duracao_prevista, :total_minutos_treinamento_sub_modulos

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

private
  
  def calcula_previsao_termino
    return if self.hora_programacao.nil?
    total_minutos = total_minutos_treinamento_sub_modulos
    self.data_previsao_termino = data_hora_inicio_previsto + total_minutos.minutes
  end

  def data_programacao_valida
    return if self.hora_programacao.nil?
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

    if p.any?
      errors.add(:usuario_id,"Existe conflito de horário com a agenda do Técnico.")
    end
  end
end
