class CreateUsuarioConfigs < ActiveRecord::Migration
  def self.up
    create_table :usuario_configs do |t|
      t.integer :usuario_id, :nil => false
      t.text :assinatura_email
      t.timestamps
    end
    add_index(:usuario_configs,:usuario_id)
    add_foreign_key(:usuario_configs,:usuarios,:dependent => :delete)
  end
  
  def self.down
    drop_table :usuario_configs
  end
end
