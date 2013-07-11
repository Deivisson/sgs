class Situacao < ActiveRecord::Base
  
  validates :descricao, :presence => true, :length => {:maximum => 30}
  validates_associated :ordem_servico_itens

  has_many :ordem_servico_itens
end
