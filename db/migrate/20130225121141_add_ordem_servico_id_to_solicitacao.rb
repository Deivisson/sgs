class AddOrdemServicoIdToSolicitacao < ActiveRecord::Migration
  def change
  	add_column :solicitacoes, :ordem_servico_id, :integer
  	add_foreign_key :solicitacoes, :ordem_servicos, :name => "fk_solicitacoes_ordem_servicos"
  end

end
