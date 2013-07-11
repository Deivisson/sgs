# -*- encoding : utf-8 -*-
class ConsultaCampo < ActiveRecord::Base

  validates_presence_of :consulta_id, :descricao,:tabela, :campo, :alias
  belongs_to :consulta
  
end
