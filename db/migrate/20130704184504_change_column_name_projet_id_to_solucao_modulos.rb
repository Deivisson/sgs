class ChangeColumnNameProjetIdToSolucaoModulos < ActiveRecord::Migration
  def change
    remove_foreign_key :solucao_modulos, :name => 'fk_modulos_projeto'
    remove_index :solucao_modulos, :name =>  'index_projeto_modulos_on_projeto_id'
    

  	rename_column :solucao_modulos, :projeto_id, :solucao_id
    
    add_index :solucao_modulos, :solucao_id
    add_foreign_key :solucao_modulos, :solucoes, :name => 'fk_modulos_solucoes'
  end
end
