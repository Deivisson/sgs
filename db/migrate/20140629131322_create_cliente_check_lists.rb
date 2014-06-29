class CreateClienteCheckLists < ActiveRecord::Migration
  def change
    create_table :cliente_check_lists do |t|
      t.references :check_list_item, null:false
      t.references :cliente, null:false
      t.boolean :disponivel
      t.date :data_prevista
      t.string :motivo, limit:255
      t.integer :responsavel
      t.string :nome_responsavel, limit:255

      t.timestamps
    end
    add_index :cliente_check_lists, :check_list_item_id
    add_index :cliente_check_lists, :cliente_id
    add_foreign_key :cliente_check_lists, :clientes, name:'cliente_check_lists_clientes'
    add_foreign_key :cliente_check_lists, :check_list_itens, name:'cliente_check_lists_check_list_itens'
  end
end
