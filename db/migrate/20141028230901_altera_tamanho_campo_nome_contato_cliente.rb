class AlteraTamanhoCampoNomeContatoCliente < ActiveRecord::Migration
  def change
  	change_column :cliente_contatos, :telefone, :string, limit:30
  end
end
