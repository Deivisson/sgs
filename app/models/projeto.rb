class Projeto < ActiveRecord::Base
  belongs_to :cliente

  validates :nome, presence:true, length:{maximum:50}, uniqueness: {scope: :cliente_id}
  validates :cliente_id, presence:true
  validates :data_inicio, presence:true
  validates :data_prevista_termino, presence:true

  validate :previsao_termino_menor_que_data_inicio

private 

  def previsao_termino_menor_que_data_inicio
  	return if data_inicio.nil? || data_prevista_termino.nil?
  	if data_inicio > data_prevista_termino
  		errors.add(:data_prevista_termino, "Data Prevista para Termino devera ser maior que a Data de Inicio.")
  	end
  end
end
