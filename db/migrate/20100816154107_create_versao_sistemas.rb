class CreateVersaoSistemas < ActiveRecord::Migration
  def self.up
    create_table :versao_sistemas do |t|
      t.string :versao, :limit => 10,:nil => false
      t.text :detalhe,:nil => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :versao_sistemas
  end
end
