class CreateProjetosSolucoes < ActiveRecord::Migration
  def change
    create_table :projetos_solucoes, id:false do |t|
      t.references :projeto, null:false
      t.references :solucao, null:false
      t.timestamps
    end
    add_index :projetos_solucoes, :projeto_id
    add_index :projetos_solucoes, :solucao_id
    add_foreign_key :projetos_solucoes, :projetos, name:'projetos_solucoes_projetos'
    add_foreign_key :projetos_solucoes, :solucoes, name:'projetos_solucoes_solucoes'
  end
end
