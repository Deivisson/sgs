class AddVersaoSistemaIdToUsuarioConfigs < ActiveRecord::Migration
  def self.up
    add_column :usuario_configs, :versao_sistema_id,:integer,:nil => false,:default => 0
  end

  def self.down
    remove_column :usuario_configs, :versao_sistema_id
  end
end
