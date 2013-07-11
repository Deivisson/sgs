class CreateProjetoSubModulos < ActiveRecord::Migration
  def self.up
    create_table :projeto_sub_modulos do |t|
      t.integer :projeto_modulo_id
      t.string :descricao, :limit => 50, :null => false
      t.string :detalhe, :limit => 255
      t.date :data_criacao
      t.timestamps
    end

    add_index :projeto_sub_modulos, :projeto_modulo_id
    add_foreign_key :projeto_sub_modulos, :projeto_modulos, :name => 'fk_sub_modulos_modulos'

  end

  def self.down
    drop_table :projeto_sub_modulos
  end
end
