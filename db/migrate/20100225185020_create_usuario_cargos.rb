class CreateUsuarioCargos < ActiveRecord::Migration
  def self.up
    create_table :usuario_cargos do |t|
      t.string :descricao,:limit => 30, :null => false
      t.timestamps
    end
    execute(insert_default)
  end
  
  def self.insert_default
    <<-END_OF_DATA
    insert into usuario_cargos (id,descricao,created_at, updated_at)  values
    (1,'Administrador','20120101','20120101')
    END_OF_DATA
  end

  def self.down
    drop_table :usuario_cargos
  end
end
