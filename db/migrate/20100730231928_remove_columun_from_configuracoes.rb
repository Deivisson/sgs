class RemoveColumunFromConfiguracoes < ActiveRecord::Migration
  def self.up
    remove_foreign_key(:configuracoes,:name => "fk_atendimento_configuracao")
    remove_column :configuracoes,:atendimento_padrao_id
  end

  def self.down
  end
end
