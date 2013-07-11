class RemoveTimestampsColumnsFromClienteProjetos < ActiveRecord::Migration
  def up
      remove_column :clientes_projetos, :created_at
      remove_column :clientes_projetos, :updated_at
  end

  def down
  end
end
