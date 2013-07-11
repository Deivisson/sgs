class RemoveTimestampsColumnsFromProjetosUsuarios < ActiveRecord::Migration
  def up
    remove_column :projetos_usuarios, :created_at
    remove_column :projetos_usuarios, :updated_at
  end

  def down
  end
end
