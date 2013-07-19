class AddPesoToSolicitacoes < ActiveRecord::Migration
  def change
    add_column :solicitacoes, :peso, :integer
  end
end
