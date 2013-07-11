class AddConfirmacaoLeituraToSolicitacao < ActiveRecord::Migration
  def self.up
    add_column :solicitacoes,:confirmacao_leitura,:boolean
  end

  def self.down
    remove_column :solicitacoes,:confirmacao_leitura
  end
end
