class AddFieldsToSolicitacao < ActiveRecord::Migration
  def change
  	add_column :solicitacoes, :cliente_id, :integer
  	add_column :solicitacoes, :usuario_cadastrante_id, :integer

		add_index :solicitacoes, :cliente_id
		add_index :solicitacoes, :usuario_cadastrante_id
		add_foreign_key :solicitacoes,:clientes, name:'fk_solicitacoes_clientes'
		add_foreign_key :solicitacoes,:usuarios,:column =>"usuario_cadastrante_id" ,:name => "fk_solicitacaoes_usuario_cadastrante"

  end

end
