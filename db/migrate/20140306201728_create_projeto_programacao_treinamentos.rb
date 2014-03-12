class CreateProjetoProgramacaoTreinamentos < ActiveRecord::Migration
  def change
    create_table :projeto_programacao_treinamentos do |t|
      t.references :projeto, :null => false
      t.date :data_programacao, :null => false
      t.time :hora_programacao, :null => false
      t.references :usuario, :null => false
      t.string :participantes

      t.timestamps
    end
    add_index :projeto_programacao_treinamentos, :projeto_id
    add_index :projeto_programacao_treinamentos, :usuario_id
    add_foreign_key :projeto_programacao_treinamentos, :projetos, name:'projeto_programacao_treinamentos_projetos'
    add_foreign_key :projeto_programacao_treinamentos, :usuarios, name:'projeto_programacao_treinamentos_usuarios'
  end
end
