class ChangeColumnNameProjetoModuloIdToSolucaoModuloId < ActiveRecord::Migration
  def change
    remove_foreign_key :solucao_sub_modulos, :name => 'fk_sub_modulos_modulos'
    remove_index :solucao_sub_modulos, :name =>  'index_projeto_sub_modulos_on_projeto_modulo_id'
    
  	rename_column :solucao_sub_modulos, :projeto_modulo_id, :solucao_modulo_id
    
    add_index :solucao_sub_modulos, :solucao_modulo_id
    add_foreign_key :solucao_sub_modulos, :solucao_modulos, :name => 'fk_solucao_sub_modulos_projeto_modulos'
  end
end
