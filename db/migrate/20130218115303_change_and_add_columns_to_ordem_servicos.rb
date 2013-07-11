class ChangeAndAddColumnsToOrdemServicos < ActiveRecord::Migration
  def up
	change_column :ordem_servicos, :local_execucao, :integer, :null => false
	add_column :ordem_servicos, :minutos_desconto, :integer, :null => false, :default => 0	
	add_column :ordem_servicos, :tipo_tarifacao, :integer, :null => false
  end

  def down
  	change_column :ordem_servicos, :local_execucao, :string, :null => true, :limit => 100
  	remove_column :ordem_servicos, :minutos_desconto
  	remove_column :ordem_servicos, :tipo_tarifacao
  end
end
