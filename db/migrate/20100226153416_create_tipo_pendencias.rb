class CreateTipoPendencias < ActiveRecord::Migration
  def self.up
    create_table :tipo_pendencias do |t|
      t.string :descricao, :limit => 20, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_pendencias
  end
end
