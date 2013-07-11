class ChangeTableNameFromProjetoSubModulosToSolucaoSubModulos < ActiveRecord::Migration
  def change
  	rename_table :projeto_sub_modulos, :solucao_sub_modulos
  end
end
