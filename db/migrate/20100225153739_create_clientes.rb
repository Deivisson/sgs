class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes do |t|
      t.string :nome, :limit => 50, :null => false
      t.string :endereco, :limit => 50
      t.string :complemento,  :limit => 30
      t.string :bairro, :limit => 30
      t.string :cidade, :limit => 50
      t.string :uf, :limit => 2
      t.string :cep, :limit => 8
      t.string :telefone, :limit => 11
      t.string :fax, :limit => 11
      t.timestamps
    end
    
  end

  def self.down
    drop_table :clientes
  end
end
