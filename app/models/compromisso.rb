# -*- encoding : utf-8 -*-
class Compromisso < ActiveRecord::Base

	ATIVO = 1
	CANCELADO = 2
	CONCLUIDO = 3
	STATUS = ["Ativo", "Cancelado", "Concluído"]

	validates :usuario_id, presence:true
	validates :descricao, presence:true
	validates :data_inicio, presence:true
	validates :hora_inicio, presence:true
	validates :usuario_cadastrante_id, presence:true
	
  belongs_to :usuario
  belongs_to :usuario_cadastrante, 
  						class_name:"usuario", 
  						foreign_key:"usuario_cadastrante_id"
  						
	belongs_to :treinamento, 
							class_name:'ProjetoProgramacaoTreinamento',
							foreign_key:"projeto_programacao_treinamento_id"

  attr_accessible :data_fim, :data_inicio, 
  								:descricao, :hora_fim, :hora_inicio, :usuario_cadastrante_id, 
  								:usuario_id

	before_validation on: :create  do
		self.status = ATIVO
		self.data_fim = self.data_inicio
	end

	def has_treinamento?
		self.treinamento.present?
	end

	def to_text
		"#{self.hora_inicio.to_s(:time)} às #{self.hora_fim.to_s(:time)} - #{self.usuario.nome}"
	end

	def status_descricao
		STATUS[self.status - 1]
	end

	def cancelado?
		self.status == CANCELADO
	end
end
