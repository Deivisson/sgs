# -*- encoding : utf-8 -*-
class SolucaoUsuario < ActiveRecord::Base
  has_and_belongs_to_many :usuarios 
end
