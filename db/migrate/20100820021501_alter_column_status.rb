class AlterColumnStatus < ActiveRecord::Migration
  def self.up
    change_column :status,:descricao,:string, :limit => 30,:nil => false
  end

  def self.down
    change_column :status,:descricao,:string,:limit => 20, :nil => falses
  end
end
