class RemoveTimestampsColumnsFromStatusUsuarioCargos < ActiveRecord::Migration
  def up
    remove_column :status_usuario_cargos, :created_at
    remove_column :status_usuario_cargos, :updated_at
  end

  def down
  end
end
