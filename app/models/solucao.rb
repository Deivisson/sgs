# -*- encoding : utf-8 -*-
class Solucao < ActiveRecord::Base
  validates_presence_of :descricao, :data_criacao
	
  validates_uniqueness_of :descricao

  validates_length_of :descricao, :maximum => 50
  validates_length_of :detalhe, :maximum => 300, :allow_blank => true
  validates_length_of :versao_atual, :maximum => 15, :allow_blank => true
	
  has_many :solucao_modulos
  has_and_belongs_to_many :clientes
  has_and_belongs_to_many :usuarios

  scope :to_select, :select => 'descricao,id', :order => :descricao
  
  scope :to_select_by_cliente, lambda{|cliente_id|{
    :select => 'solucoes.id,solucoes.descricao',
    :joins => :clientes,
    :conditions => ['clientes.id = ?',cliente_id],
    :order => :descricao
  }}
  
end
