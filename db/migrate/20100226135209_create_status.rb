class CreateStatus < ActiveRecord::Migration
  def self.up
    create_table :status do |t|
      t.string :descricao,:limit => 20, :null => false
      t.timestamps
    end
    #execute(insert_default)
  end

  def self.down
    drop_table :status
  end

#  def self.insert_default
#    <<-END_OF_DATA
#    insert into status (id,descricao)  values
#    (1,'Aberto'),
#    (2,'Em Análise'),
#    (3,'Não Aprovado'),
#    (4,'Ag. Desenvolv'),
#    (5,'Em Desenvolv'),
#    (6,'Desenv Inter...'),
#    (7,'Ag. Homologação'),
#    (8,'Em Homologação'),
#    (9,'Homologação Reprov'),
#    (10,'Liberado Publicação'),
#    (11,'Publicado')
#    END_OF_DATA
#  end
end
