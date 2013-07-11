class ChangeColumnNameProjetoIdToSolucaoIdOnSolucoesUsuarios < ActiveRecord::Migration
  def change
    remove_foreign_key :solucoes_usuarios, :name => 'projetos_usuarios_projeto_id_fk'
    remove_index :solucoes_usuarios, :name =>  'index_projetos_usuarios_on_projeto_id'
    
  	rename_column :solucoes_usuarios, :projeto_id, :solucao_id
    
    add_index :solucoes_usuarios, :solucao_id
    add_foreign_key :solucoes_usuarios, :solucoes, :name => 'fk_solucoes_solucoes_usuarios'
  end
end
