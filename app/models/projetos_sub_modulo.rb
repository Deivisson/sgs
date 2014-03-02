# -*- encoding : utf-8 -*-
class ProjetosSubModulo < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :solucao_sub_modulo
end
