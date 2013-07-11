class CreateSituacoes < ActiveRecord::Migration
  def change
    create_table :situacoes do |t|
      t.string :descricao
  	  t.boolean :padrao, :null => false
      t.timestamps
    end
  end
end
