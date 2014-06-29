include ClienteInfrasHelper
class ClienteInfra < ActiveRecord::Base
  
  CATEGORIA_SERVIDOR_DEDICADO = 1
  CATEGORIA_SERVIDOR_COMPARTILHADO = 2
  CATEGORIA_SERVIDOR_NUVEM = 3

  TIPO_SERVIDOR_MONTADO = 1
  TIPO_SERVIDOR_PRONTO = 2

  validates :sistema_operacional, length: {maximum:100}
  validates :banco_dados, length: {maximum:100}
  validates :nome_empresa_ti, length: {maximum:100}
  validates :responsavel_ti, length: {maximum:100}
  validates :telefone, length: {maximum:100}
  validates :email, length: {maximum:100}
	validates :observacao, length: {maximum:255}
	validates :cliente_id, presence:true


  belongs_to :cliente

  def categoria_servidor_descricao
  	return if self.categoria_servidor.nil?
  	options_for_categoria_servidor[self.categoria_servidor - 1].first
  end

  def tipo_servidor_descricao
  	return if self.tipo_servidor.nil?
  	options_for_tipo_servidor[self.tipo_servidor - 1].first
  	
  end

end
