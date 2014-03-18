class AddPrevisaoTerminoToProjetoProgramacaoTreinamentos < ActiveRecord::Migration
  def change
  	add_column :projeto_programacao_treinamentos, :data_previsao_termino, :datetime
  end
end
