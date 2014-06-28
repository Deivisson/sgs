class CreateClienteInfras < ActiveRecord::Migration
  def change
    create_table :cliente_infras do |t|
      t.integer :categoria_servidor
      t.string :sistema_operacional, limit:100
      t.string :banco_dados, limit:100
      t.integer :numero_estacoes
      t.boolean :solucao_backup
      t.boolean :servidor_com_ride
      t.integer :tipo_servidor
      t.string :nome_empresa_ti, limit:100
      t.string :responsavel_ti, limit:100
      t.string :telefone, limit:100
      t.string :email, limit:100
      t.string :observacao, limit:255
      t.references :cliente, :null => false
      t.timestamps
    end
    add_foreign_key :cliente_infras, :clientes, name: 'cliente_infras_clientes'
  end
end
