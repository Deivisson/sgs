# -*- encoding : utf-8 -*-
class TipoPendencia < ActiveRecord::Base
  
  validates_presence_of :descricao
  validates_uniqueness_of :descricao 
  validates_length_of :descricao, :maximum => 20

  has_many :pendencia_itens
  
  scope :to_select, :select => 'id,descricao',:order => 'descricao'

end
