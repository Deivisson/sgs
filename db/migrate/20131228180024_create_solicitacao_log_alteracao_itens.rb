class CreateSolicitacaoLogAlteracaoItens < ActiveRecord::Migration
  def change
    create_table :solicitacao_log_alteracao_itens do |t|
      t.references :solicitacao_log_alteracao
      t.string :campo
      t.text :velho_conteudo
			t.text :novo_conteudo


      t.timestamps
    end
    add_foreign_key :solicitacao_log_alteracao_itens, :solicitacao_log_alteracoes,name:'solicitacao_log_alteracao_itens_log_alteracao'
  end
end
