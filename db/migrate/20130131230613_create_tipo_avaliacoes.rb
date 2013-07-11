class CreateTipoAvaliacoes < ActiveRecord::Migration
  def change
    create_table :tipo_avaliacoes do |t|
      t.string :descricao, :null => false, :limit => 30
      t.boolean :padrao, :null => false
      t.timestamps
    end
  end
end
