# -*- encoding : utf-8 -*-
class ClientesSolucao < ActiveRecord::Base
  #has_and_belongs_to_many :clientes
  belongs_to :cliente
  belongs_to :solucao
end
