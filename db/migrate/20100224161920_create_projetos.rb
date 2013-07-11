class CreateProjetos < ActiveRecord::Migration
  def self.up
    create_table :projetos do |t|
	t.string:descricao,:limit => 50,:null => false
	t.string:detalhe, :limit => 300
	t.date:data_criacao, :null => false
	t.date:data_ultima_atualizacao
	t.string:versao_atual, :limit => 15
        t.timestamps
    end
  end

  def self.down
    drop_table :projetos
  end
end
