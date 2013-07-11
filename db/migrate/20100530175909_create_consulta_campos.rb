class CreateConsultaCampos < ActiveRecord::Migration
  def self.up
    create_table :consulta_campos do |t|
      t.integer :consulta_id
      t.string :descricao, :limit => 30,:null => false
      t.string :tabela, :limit => 30,:null => false
      t.string :campo, :limit => 100,:null => false
      t.string :alias, :limit => 30,:null => false
      t.string :tipo, :limit => 3,:null => true
      t.string :width, :limit =>3,:null => true
      t.boolean :selecionado, :null => false,:default => false
      t.timestamps
    end
    add_index :consulta_campos, :consulta_id
    add_foreign_key :consulta_campos, :consultas, :name => "fk_consulta_campos_consultas"

  end


  def self.down
    drop_table :consulta_campos
  end
end
