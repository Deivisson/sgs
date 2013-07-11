class CreateSolicitacaoHistoricos < ActiveRecord::Migration
  def self.up
    create_table :solicitacao_historicos do |t|
      t.integer :usuario_id
      t.integer :solicitacao_id
      t.text :detalhe
      t.integer :status_id, :null => false
      t.integer :usuario_responsavel_id, :null => false
      t.timestamps
    end
    add_index(:solicitacao_historicos,:usuario_id)
    add_index(:solicitacao_historicos,:solicitacao_id)
    add_index(:solicitacao_historicos,:status_id)
    add_index(:solicitacao_historicos,:usuario_responsavel_id)
	
    add_foreign_key(:solicitacao_historicos,:solicitacoes,:name => "fk_solicitacao_historico_solicitacoes",:dependent => :delete)
    add_foreign_key(:solicitacao_historicos,:usuarios,:name => "fk_solicitacao_historico_usuarios")
    add_foreign_key(:solicitacao_historicos,:status,:name =>"fk_solicitacao_historico_status")
    add_foreign_key(:solicitacao_historicos,:usuarios,:column => "usuario_responsavel_id",:name => "fk_solicitacao_historico_usuario_responsavel")
  end

  def self.down
    drop_table :solicitacao_historicos
  end
end
