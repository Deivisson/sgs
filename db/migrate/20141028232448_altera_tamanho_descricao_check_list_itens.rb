class AlteraTamanhoDescricaoCheckListItens < ActiveRecord::Migration
  def change
  	change_column :check_list_itens, :descricao, :string, limit:255
  end
end
