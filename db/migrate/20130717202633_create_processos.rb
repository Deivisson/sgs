class CreateProcessos < ActiveRecord::Migration
  def change
    create_table :processos do |t|
      t.string :descricao
      t.integer :pontos_funcao
      t.timestamps
    end
  end
end
