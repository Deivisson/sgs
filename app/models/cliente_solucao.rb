# -*- encoding : utf-8 -*-
class ClienteSolucao < ActiveRecord::Base
  has_and_belongs_to_many :clientes
end
