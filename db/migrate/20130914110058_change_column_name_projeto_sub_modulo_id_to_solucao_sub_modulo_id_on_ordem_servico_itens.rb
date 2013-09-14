class ChangeColumnNameProjetoSubModuloIdToSolucaoSubModuloIdOnOrdemServicoItens < ActiveRecord::Migration
	def change
    remove_foreign_key :ordem_servico_itens, :name => 'fk_ordem_servico_itens_sub_modulo'
    remove_index :ordem_servico_itens, :name =>  'index_ordem_servico_itens_on_projeto_sub_modulo_id'
    
  	rename_column :ordem_servico_itens, :projeto_sub_modulo_id, :solucao_sub_modulo_id
    
    add_index :ordem_servico_itens, :solucao_sub_modulo_id
    add_foreign_key :ordem_servico_itens, :solucao_sub_modulos, :name => 'fk_solucao_sub_modulos_ordem_servico_itens'
  end
end
