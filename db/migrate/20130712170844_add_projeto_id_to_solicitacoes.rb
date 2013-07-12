class AddProjetoIdToSolicitacoes < ActiveRecord::Migration
  def change
    add_column :solicitacoes, :projeto_id, :integer
    add_index :solicitacoes,:projeto_id
    add_foreign_key :solicitacoes, :projetos, name:'fk_solicitacoes_projetos'
  end
end
