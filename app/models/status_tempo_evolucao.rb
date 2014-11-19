# -*- encoding : utf-8 -*-
include DataHoraHelper
class StatusTempoEvolucao < ActiveRecord::Base

	validates :status_id, presence:true
	validates :tipo_pendencia_id, presence:true,:uniqueness =>{:scope =>[:prioridade_id,:status_id]}
	validates :prioridade_id, presence:true
	validates :tempo_horas, presence:true
	validates :tempo_minutos, presence:true

  belongs_to :status
  belongs_to :tipo_pendencia
  belongs_to :prioridade

  attr_accessor :tempo_horas
  before_validation :attribui_minutos_tempo

  def tempo_horas
    return "-" if self.tempo_minutos.nil?
    minutos_em_horas(self.tempo_minutos)
  end

  def self.by_solicitacao(solicitacao)
    StatusTempoEvolucao.where(
        "status_id = ? and tipo_pendencia_id = ? and prioridade_id = ?",
        solicitacao.status_id, solicitacao.tipo_pendencia_id,solicitacao.prioridade_id).first
  end

private
	
  def attribui_minutos_tempo
    return if @tempo_horas.nil? || @tempo_horas.empty?
    self.tempo_minutos = total_minutos(@tempo_horas)
  end
end
