class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.integer :usuario_cargo_id
      t.string :nome, :limit => 50, :null => false
      t.string :email, :limit => 50, :null => false
      t.string :celular,:limit => 11
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end
    add_index :usuarios, :usuario_cargo_id
    add_index :usuarios, :email,                :unique => true
    add_index :usuarios, :confirmation_token,   :unique => true
    add_index :usuarios, :reset_password_token, :unique => true

    add_foreign_key :usuarios, :usuario_cargos, :name => "fk_usuarios_usuarios_cargos"

  end

  def self.down
    drop_table :usuarios
  end
end
