class CreateStatusUsuarioCargos < ActiveRecord::Migration
  def self.up
    create_table :status_usuario_cargos, :id => false do |t|
      t.integer :status_id
      t.integer :usuario_cargo_id
      t.timestamps
    end
    add_foreign_key(:status_usuario_cargos,:usuario_cargos,:name => 'fk_status_usuario_cargos_cargos')
    add_foreign_key(:status_usuario_cargos,:status,:name => 'fk_status_usuario_cargos_status')
  end

  def self.down
    drop_table :status_usuario_cargos
  end
end
