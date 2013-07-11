class AddColumnsToSolicitacoes < ActiveRecord::Migration
  def change
  	add_column :solicitacoes, :previsao_duracao_minutos, :integer
  	add_column :solicitacoes, :nivel_complexidade, :integer
  	add_column :solicitacoes, :gera_cobranca, :boolean
  	add_column :solicitacoes, :valor_cobranca, :decimal, :precision => 10, :scale => 2, :null => false, :default => 0
  end
end
