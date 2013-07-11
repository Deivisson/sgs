class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :nome, :limit => 50, :null => false
      t.text :descricao
      t.references :cliente, :null => false
      t.date :data_inicio, :null => false
      t.date :data_prevista_termino, :null => false

      t.timestamps
    end
    add_index :projetos, :cliente_id
    add_foreign_key :projetos, :clientes, :name => "fk_projetos_clientes"
  end
end
