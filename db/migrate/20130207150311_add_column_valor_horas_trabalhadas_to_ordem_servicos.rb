class AddColumnValorHorasTrabalhadasToOrdemServicos < ActiveRecord::Migration
  def change
	add_column :ordem_servicos, :minutos_faturados, :integer, :null => false, :default => 0	
	add_column :ordem_servicos, :minutos_bonus_utilizados, :integer, :null => false, :default => 0	
	add_column :ordem_servicos, :valor_servico, :decimal, :null => false, :default => 0, :precision => 10, :scale => 2
  end
end
