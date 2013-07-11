class AddOrdemToConsultaCampos < ActiveRecord::Migration
  def self.up
    add_column :consulta_campos, :ordem,:integer
    add_column :consulta_campos, :padrao,:boolean,:default => false
  
   #execute(update_registro_padrao)  
  end

  def self.down
    remove_column :consulta_campos, :ordem
    remove_column :consulta_campos, :padrao
  end

  def self.update_registro_padrao
    <<-END_OF_DATA
     update consulta_campos set padrao = 1;
     END_OF_DATA
  end
end
