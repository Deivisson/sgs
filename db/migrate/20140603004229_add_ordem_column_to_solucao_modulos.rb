class AddOrdemColumnToSolucaoModulos < ActiveRecord::Migration
  def change
  	add_column :solucao_modulos, :ordem, :integer, :null => false, :default => 0
  end
end
