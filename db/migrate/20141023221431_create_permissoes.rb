class CreatePermissoes < ActiveRecord::Migration
  def change
    create_table :permissoes do |t|
      t.string :descricao, limit:250, null:false
      t.string :chave, limit:30, null:false
      t.integer :parent_id
      t.timestamps
    end
  end
end
