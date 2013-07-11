class AddColumnInternoToAtendimento < ActiveRecord::Migration
  def self.up
    add_column :atendimentos, :interno, :boolean,:default => false,:null => false
  end

  def self.down
    remove_column :atendimentos,:interno
  end
end
