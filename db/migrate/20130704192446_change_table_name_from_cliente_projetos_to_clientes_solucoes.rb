class ChangeTableNameFromClienteProjetosToClientesSolucoes < ActiveRecord::Migration
  def change
  	rename_table :clientes_projetos, :clientes_solucoes
  end
end
