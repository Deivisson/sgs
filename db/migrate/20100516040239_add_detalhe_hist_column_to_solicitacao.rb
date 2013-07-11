class AddDetalheHistColumnToSolicitacao < ActiveRecord::Migration
  def self.up
    add_column :solicitacoes, :detalhe_ultimo_historico, :text
  end

  def self.down
    remove_column :solicitacoes, :detalhe_ultimo_historico
  end
end
