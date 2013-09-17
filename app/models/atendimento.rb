# -*- encoding : utf-8 -*-
class Atendimento < ActiveRecord::Base

  validates_presence_of :cliente_id, :usuario_cadastrante_id,:usuario_solicitante_id
  validates_length_of :descricao, :maximum => 50
  
  #has_many :solicitacoes
  belongs_to :cliente
  belongs_to :usuario_cadastrante,:class_name => "Usuario",:foreign_key => "usuario_cadastrante_id"
  belongs_to :usuario_solicitante,:class_name => "Usuario",:foreign_key => "usuario_solicitante_id"

  scope :lista_atendimentos, :joins => [:cliente,:usuario_solicitante],
              :select =>'atendimentos.id,atendimentos.descricao,atendimentos.created_at,clientes.nome as nome_cliente,usuarios.nome as solicitante', 
              :conditions => {:interno => false}, :order => 'id desc'
end
