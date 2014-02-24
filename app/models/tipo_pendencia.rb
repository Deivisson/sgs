# -*- encoding : utf-8 -*-
class TipoPendencia < ActiveRecord::Base
  
  validates_presence_of :descricao
  validates_uniqueness_of :descricao 
  validates_length_of :descricao, :maximum => 20

  #has_many :pendencia_itens
  has_many :solicitacoes
  has_many :status_tempo_evolucoes

  scope :to_select, :select => 'id,descricao',:order => 'descricao'

end
