class ChangeColumnNameProjectIdToSolucaoIdOnClientesSolucoes < ActiveRecord::Migration
  def change
    remove_foreign_key :clientes_solucoes, :name => 'clientes_projetos_projeto_id_fk'
    remove_index :clientes_solucoes, :name =>  'index_clientes_projetos_on_projeto_id'
    
  	rename_column :clientes_solucoes, :projeto_id, :solucao_id
    
    add_index :clientes_solucoes, :solucao_id
    add_foreign_key :clientes_solucoes, :solucoes, :name => 'fk_solucoes_clientes'
  end
end
