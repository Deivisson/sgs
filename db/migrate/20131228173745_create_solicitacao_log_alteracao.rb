class CreateSolicitacaoLogAlteracao < ActiveRecord::Migration
  def change
  	create_table :solicitacao_log_alteracoes do |t|
      t.references :usuario
      t.references :solicitacao
      t.timestamps
    end
    add_foreign_key :solicitacao_log_alteracoes, :usuarios, name:'solicitacao_log_alteracoes_usuarios'
    add_foreign_key :solicitacao_log_alteracoes, :solicitacoes, name:'solicitacao_log_alteracoes_solicitacoes'
  end
end
