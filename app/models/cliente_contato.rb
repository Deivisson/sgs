# -*- encoding : utf-8 -*-
class ClienteContato < ActiveRecord::Base

  validates_presence_of :nome, :cliente_id
  validates_format_of :email,:with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'e-mail inválido' 
  validates_uniqueness_of :email

  validates_length_of :nome, :maximum => 50
  validates_length_of :departamento, :maximum => 30, :allow_blank => true
  validates_length_of :email, :maximum => 50, :allow_blank => true
  validates_length_of :telefone, :maximum => 11, :allow_blank => true
  validates_length_of :celular, :maximum => 11, :allow_blank => true

  belongs_to :cliente
  has_many :pendencia_itens
  has_many :ordem_servicos
    
  scope :lista_contatos,:joins =>[:cliente],:select => 'cliente_contatos.*,clientes.nome as cliente_nome', 
                              :order => "clientes.nome"

  scope :to_select_by_cliente, lambda {|cliente_id|{
    :select => 'id,nome',
    :conditions => ['cliente_id = ?', cliente_id], 
    :order => :nome
  }}
end
