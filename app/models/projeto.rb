class Projeto < ActiveRecord::Base
  
  ATIVO = 1
  EM_ANDAMENTO = 2
  INTERROMPIDO = 3
  CANCELADO = 4
  
  STATUS = ["Ativo", "Em Andamento", "Interrompido", "Cancelado"]


  validates :nome, presence:true, length:{maximum:50}, uniqueness: {scope: :cliente_id}
  validates :cliente_id, presence:true
  validates :data_inicio, presence:true
  validates :data_prevista_termino, presence:true
  validates :status, presence:true
  validates :usuario_id, presence:true

  validate :previsao_termino_menor_que_data_inicio
  
  belongs_to :cliente
  belongs_to :usuario
  has_many :solicitacoes
  
  def informacoes_sobre_criacao
    "#{created_at.strftime("%d/%m/%y")} por #{usuario.nome}"
  end

  def descricao_status
    STATUS[status - 1]
  end

private 

  def previsao_termino_menor_que_data_inicio
  	return if data_inicio.nil? || data_prevista_termino.nil?
  	if data_inicio > data_prevista_termino
  		errors.add(:data_prevista_termino, "Data Prevista para Termino devera ser maior que a Data de Inicio.")
  	end
  end
end
