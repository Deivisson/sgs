class AddMensagemOsToConfiguracoes < ActiveRecord::Migration
  def change
  		add_column :configuracoes, :mensagem_os,:text
  end
end
