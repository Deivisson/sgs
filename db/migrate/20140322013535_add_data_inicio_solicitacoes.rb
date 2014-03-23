class AddDataInicioSolicitacoes < ActiveRecord::Migration
  def change
  	add_column :solicitacoes, :data_inicio, :date
  	add_column :solicitacoes, :hora_inicio, :time
  end
end
