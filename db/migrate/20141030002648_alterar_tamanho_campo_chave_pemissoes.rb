class AlterarTamanhoCampoChavePemissoes < ActiveRecord::Migration
  def change
  	change_column :permissoes, :chave, :string, limit:100
  end
end
