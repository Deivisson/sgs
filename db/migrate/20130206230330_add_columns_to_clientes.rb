class AddColumnsToClientes < ActiveRecord::Migration
  def change
  	add_column :clientes, :minutos_bonus, :integer, :null => false, :default => 0
  	add_column :clientes, :valor_hora_visita, :decimal, :precision => 10, :scale => 6, :null => false, :default => 0
  	add_column :clientes, :valor_deslocamento, :decimal, :precision => 5,:scale =>  2, :null => false, :default => 0
  end
end
