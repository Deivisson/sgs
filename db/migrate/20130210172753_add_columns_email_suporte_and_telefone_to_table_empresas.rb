class AddColumnsEmailSuporteAndTelefoneToTableEmpresas < ActiveRecord::Migration
  def change
	add_column :empresas, :email_suporte, :string, :limit => 60
	add_column :empresas, :telefone, :string, :limit => 14
  end
end

