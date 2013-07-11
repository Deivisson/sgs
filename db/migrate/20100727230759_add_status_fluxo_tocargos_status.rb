class AddStatusFluxoTocargosStatus < ActiveRecord::Migration
  def self.up
    add_column :status_usuario_cargos, :status_fluxo,:string
  end

  def self.down
    remove_column :status_usuario_cargos, :status_fluxo
  end
end
