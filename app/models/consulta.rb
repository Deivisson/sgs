# -*- encoding : utf-8 -*-
class Consulta < ActiveRecord::Base
  has_many :consulta_campos
end
