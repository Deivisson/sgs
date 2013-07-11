class CreateClienteContatos < ActiveRecord::Migration
  def self.up
    create_table :cliente_contatos do |t|
      t.integer :cliente_id, :null => false
      t.string :nome, :limit => 50, :null => false
      t.string :departamento, :limit => 30
      t.string :email, :limit => 50
      t.string :telefone, :limit => 11
      t.string :celular, :limit => 11

      t.timestamps
    end

    add_index :cliente_contatos, :cliente_id
    add_foreign_key :cliente_contatos, :clientes, :name => "fk_cliente_contatos_clientes"

  end

  def self.down
    drop_table :cliente_contatos
  end
end
