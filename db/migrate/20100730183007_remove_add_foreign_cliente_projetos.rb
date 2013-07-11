class RemoveAddForeignClienteProjetos < ActiveRecord::Migration
  def self.up
    #remove_foreign_key(:clientes_projetos,:clientes)
    add_foreign_key :clientes_projetos,:clientes,:dependent => :delete
  end

  def self.down
  end
end
