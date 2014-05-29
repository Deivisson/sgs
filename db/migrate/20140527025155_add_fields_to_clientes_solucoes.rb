class AddFieldsToClientesSolucoes < ActiveRecord::Migration
  def change
  	add_column :clientes_solucoes, :data_aquisicao, :date
  	add_column :clientes_solucoes, :num_contrato, :string, :limit => 20
  end
end
