class AddColumnsToOrdemServicos < ActiveRecord::Migration
  def change
  	add_column :ordem_servicos, :data_execucao, :date, :null => false
  	add_column :ordem_servicos, :minutos_trabalhados, :integer, :null => false, :default => 0
  end
end
