class CreateProjetoModulos < ActiveRecord::Migration
  def self.up
    create_table :projeto_modulos do |t|
      t.integer :projeto_id
      t.string :descricao, :limit => 50, :null => false
      t.string :detalhe, :limit => 255

      t.timestamps
    end
    add_index :projeto_modulos, :projeto_id
    add_foreign_key :projeto_modulos, :projetos, :name => 'fk_modulos_projeto'
  end

  def self.down
    drop_table :projeto_modulos
  end
end
