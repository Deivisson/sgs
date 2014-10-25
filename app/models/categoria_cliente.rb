# -*- encoding : utf-8 -*-
class CategoriaCliente < ActiveRecord::Base
	validates :descricao, presence:true, length: {maximum:100}, uniqueness:true
  attr_accessible :descricao
  has_many :clientes

  before_destroy do
  	cliente = Cliente.where(categoria_cliente_id:self.id).limit(1).first
  	unless cliente.nil?
  		self.errors.add(:base,"Categoria em uso. Exclusão não permitida!")
  		false
		end
  end
end
