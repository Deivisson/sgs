class AddMotivoCancelamentoAndStatusToProjetoProgramacaoTreinamentos < ActiveRecord::Migration
  def change
  	add_column :projeto_programacao_treinamentos, :motivo_cancelamento, :text
  	add_column :projeto_programacao_treinamentos, :status, :integer
  end
end
