class CreateAtendimentos < ActiveRecord::Migration
  def self.up
    create_table :atendimentos do |t|
      t.integer :cliente_id, :null => false
      t.integer :usuario_cadastrante_id, :null => false
      t.integer :usuario_solicitante_id, :null => false
      t.string :descricao, :limit => 50, :null => false
      t.text :observacao

      t.timestamps
    end

    add_index(:atendimentos,:cliente_id)
    add_index(:atendimentos,:usuario_cadastrante_id)
    add_index(:atendimentos,:usuario_solicitante_id)
    add_foreign_key(:atendimentos,:clientes,:name => "fk_atendimentos_clientes")
    add_foreign_key(:atendimentos,:usuarios,:column =>"usuario_cadastrante_id" ,:name => "fk_atendimentos_usuario_cadastrante") 
    add_foreign_key(:atendimentos,:usuarios,:column => "usuario_solicitante_id",:name => "fk_atendimentos_usuario_solicitante")

  end

  def self.down
    drop_table :atendimentos
  end
end
