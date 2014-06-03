class Compromisso < ActiveRecord::Base
  belongs_to :usuario
  attr_accessible :data_fim, :data_inicio, :descricao, :hora_fim, :hora_inicio, :usuario_cadastrante_id
end
