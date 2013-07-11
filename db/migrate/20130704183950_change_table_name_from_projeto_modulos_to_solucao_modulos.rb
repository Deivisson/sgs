class ChangeTableNameFromProjetoModulosToSolucaoModulos < ActiveRecord::Migration
  def change
  	rename_table :projeto_modulos, :solucao_modulos
  end
end
