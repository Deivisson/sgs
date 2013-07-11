class ChangeColumnsOrdemServico < ActiveRecord::Migration
  def up
  	change_column :ordem_servicos, :hora_inicio, :time, :null => true
	change_column :ordem_servicos, :hora_fim, :time, :null => true
  end

  def down
  	change_column :ordem_servicos, :hora_inicio, :time, :null => false
	change_column :ordem_servicos, :hora_fim, :time, :null => false	
  end
end
