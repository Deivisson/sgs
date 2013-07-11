class CreateEmpresas < ActiveRecord::Migration
  def self.up
    create_table :empresas do |t|
      t.string :razao, :limit => 50, :null => false
      t.string :fantasia, :limit => 40, :null => false
      t.string :cnpj, :limit => 14
      t.string :endereco, :limit => 50
      t.string :complemento, :limit => 30
      t.string :cidade, :limit => 50
      t.string :uf, :limit => 2

      t.timestamps
    end
    execute(insert_default)
  end

  def self.insert_default
    <<-END_OF_DATA
    insert into empresas (id,razao,fantasia,created_at,updated_at)  values
    (1,'Razao Social Empresa', 'Nome Fantasia Empresa','20120101','20120101')
    END_OF_DATA
  end

  def self.down
    drop_table :empresas
  end
end
