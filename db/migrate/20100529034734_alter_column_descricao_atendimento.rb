class AlterColumnDescricaoAtendimento < ActiveRecord::Migration
  def self.up
    change_column :atendimentos, :descricao,:string,:limit => 50, :null => true
  end

  def self.down
    change_column :atendimentos, :descricao,:string,:limit => 50, :null => false
  end
end
