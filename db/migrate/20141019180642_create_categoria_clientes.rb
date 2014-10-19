class CreateCategoriaClientes < ActiveRecord::Migration
  def change
    create_table :categoria_clientes do |t|
      t.string :descricao, null:false, limit: 100
      t.timestamps
    end
  end
end
