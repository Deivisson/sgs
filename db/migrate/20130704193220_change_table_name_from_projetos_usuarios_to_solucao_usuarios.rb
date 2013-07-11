class ChangeTableNameFromProjetosUsuariosToSolucaoUsuarios < ActiveRecord::Migration
  def change
  	rename_table :projetos_usuarios, :solucoes_usuarios
  end
end
