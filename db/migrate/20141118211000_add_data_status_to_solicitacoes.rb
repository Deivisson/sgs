class AddDataStatusToSolicitacoes < ActiveRecord::Migration
  def change
  	add_column :solicitacoes, :data_status, :datetime
  end
end
