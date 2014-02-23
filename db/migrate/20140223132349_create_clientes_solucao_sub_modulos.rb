class CreateClientesSolucaoSubModulos < ActiveRecord::Migration
  def change
    create_table :clientes_solucao_sub_modulos,id:false do |t|
    	t.integer :cliente_id, :null => false
    	t.integer :solucao_sub_modulo_id, :null => false
      t.timestamps
    end
    add_foreign_key :clientes_solucao_sub_modulos,:clientes,:name => "clientes_solucao_sub_modulos_clientes"
    add_foreign_key :clientes_solucao_sub_modulos,:solucao_sub_modulos,:name => "clientes_solucao_sub_modulos_solucao_sub_modulos"
  end
end
