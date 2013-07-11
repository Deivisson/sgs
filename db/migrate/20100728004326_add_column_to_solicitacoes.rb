class AddColumnToSolicitacoes < ActiveRecord::Migration
  def self.up
    add_column :solicitacoes,:nao_lido,:boolean,:nil => false,:default => false
  end

  def self.down
    remove_column :solicitacoes,:nao_lido
  end
end
