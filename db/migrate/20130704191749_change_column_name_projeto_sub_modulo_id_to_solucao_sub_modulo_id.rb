class ChangeColumnNameProjetoSubModuloIdToSolucaoSubModuloId < ActiveRecord::Migration
  def change
    remove_foreign_key :solicitacoes, :name => 'fk_solicitacoes_projeto_sub_modulos'
    remove_index :solicitacoes, :name =>  'index_solicitacoes_on_projeto_sub_modulo_id'
    
  	rename_column :solicitacoes, :projeto_sub_modulo_id, :solucao_sub_modulo_id
    
    add_index :solicitacoes, :solucao_sub_modulo_id
    add_foreign_key :solicitacoes, :solucao_sub_modulos, :name => 'fk_solucao_sub_modulos_solicitacoes'
  end
end
