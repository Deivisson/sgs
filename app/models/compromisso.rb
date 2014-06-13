class Compromisso < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :usuario_cadastrante, 
  						class_name:"usuario", 
  						foreign_key:"usuario_cadastrante_id"

	ATIVO = 1
	CANCELADO = 2
	CONCLUIDO = 3
	
	belongs_to :projeto_programacao_treinamento
  attr_accessible :data_fim, :data_inicio, :descricao, :hora_fim, :hora_inicio, :usuario_cadastrante_id
end
