class CreatePrioridades < ActiveRecord::Migration
  def self.up
    create_table :prioridades do |t|
      t.string :descricao, :limit => 20, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :prioridades
  end
end
