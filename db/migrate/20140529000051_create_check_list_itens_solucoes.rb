class CreateCheckListItensSolucoes < ActiveRecord::Migration
  def change
    create_table :check_list_itens_solucoes, :id => false do |t|
      t.references :check_list_item, :null => false
      t.references :solucao, :null => false

      t.timestamps
    end
    add_index :check_list_itens_solucoes, :check_list_item_id
    add_index :check_list_itens_solucoes, :solucao_id
  end
end
