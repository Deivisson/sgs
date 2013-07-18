class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.string :descricao
      t.timestamps
    end
  end
end
