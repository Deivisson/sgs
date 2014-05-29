class CreateCheckListItens < ActiveRecord::Migration
  def change
    create_table :check_list_itens do |t|
      t.string :descricao, :null => false, :limit => 50
      t.timestamps
    end
  end
end
