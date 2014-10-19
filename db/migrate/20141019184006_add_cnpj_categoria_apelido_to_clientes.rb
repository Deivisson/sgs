class AddCnpjCategoriaApelidoToClientes < ActiveRecord::Migration
  def change
  	add_column :clientes, :apelido, :string, :limit => 100, null:false
  	add_column :clientes, :cnpj, :string, :limit => 14, null:false
  	add_column :clientes, :categoria_cliente_id, :integer
  	add_foreign_key :clientes, :categoria_clientes, name:"clientes_categorias_clientes"
  end
end
