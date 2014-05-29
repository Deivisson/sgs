class AddOrdemColumnToSolucoes < ActiveRecord::Migration
  def change
  	add_column :solucoes, :ordem, :integer, :null => false, :default => 0
  end
end
