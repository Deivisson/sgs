class CreateOrdemServicos < ActiveRecord::Migration
  def change
    create_table :ordem_servicos do |t|
      t.references :cliente, :null => false
      t.string :local_execucao, :limit => 100
      t.references :cliente_contato, :null => false  
      t.integer :tipo_os, :null => false
      t.integer :usuario_responsavel_id, :null => false
      t.integer :usuario_cadastrante_id, :null => false
      t.time :hora_inicio, :null => false
      t.time :hora_fim, :null => false
      t.time :tempo_intervalo
      t.text :descricao
      t.text :observacoes
      t.string :usuarios_participantes, :null => false, :limit => 254
      t.decimal :valor_total, :null => false, :default => 0, :precision => 10, :scale => 2
      t.decimal :valor_deslocamento, :null => false , :default => 0,:precision => 10, :scale => 2
      t.timestamps
    end
    add_index :ordem_servicos, :cliente_id
    add_index :ordem_servicos, :cliente_contato_id
    add_index :ordem_servicos, :usuario_responsavel_id
    add_index :ordem_servicos, :usuario_cadastrante_id
    add_foreign_key :ordem_servicos, :clientes, :name => "fk_ordem_servicos_cliente"
    add_foreign_key :ordem_servicos, :cliente_contatos, :name => "fk_ordem_servicos_cliente_contato"
    add_foreign_key :ordem_servicos, :usuarios,:column =>"usuario_responsavel_id", :name => "fk_ordem_servicos_usuarios_responsaveis"
    add_foreign_key :ordem_servicos, :usuarios,:column =>"usuario_cadastrante_id", :name => "fk_ordem_servicos_usuarios_cadastrantes"
  end
end
