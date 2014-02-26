class AddOrdemToEtapas < ActiveRecord::Migration
  def change
  	add_column :etapas, :ordem, :integer, null:false, :default => 0
  end
end
