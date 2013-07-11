class CreateConsultas < ActiveRecord::Migration
  def self.up
    create_table :consultas do |t|
      t.string :descricao, :limit => 50, :null => false
      t.timestamps
    end
    #execute(insert_consulta_solicitacoes)
  end

#  def self.insert_consulta_solicitacoes
#    <<-END_OF_DATA
#    insert into consultas (id,descricao)  values
#			 (1,'Consulta Solicitações')
#    END_OF_DATA
#  end

  def self.down
    drop_table :consultas
  end
end
