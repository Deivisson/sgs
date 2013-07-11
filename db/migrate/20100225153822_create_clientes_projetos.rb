class CreateClientesProjetos < ActiveRecord::Migration
  def self.up
    create_table :clientes_projetos, :id => false do |t|
      t.integer :cliente_id, :null => false
      t.integer :projeto_id, :null => false
      t.timestamps
    end

    add_index :clientes_projetos, :cliente_id
    add_index :clientes_projetos, :projeto_id
    add_foreign_key :clientes_projetos, :clientes, :name => "fk_clientes_porjetos_clientes"
    add_foreign_key :clientes_projetos, :projetos, :name => "fk_clientes_porjetos_projetos"
  end

  def self.down
    drop_table :clientes_projetos
  end
end
