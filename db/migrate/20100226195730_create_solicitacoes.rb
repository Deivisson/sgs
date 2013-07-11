class CreateSolicitacoes < ActiveRecord::Migration
  def self.up
    create_table :solicitacoes do |t|
      t.integer :atendimento_id , :null => false
      t.integer :status_id, :null => false
      t.integer :prioridade_id, :null => false
      t.integer :projeto_sub_modulo_id, :null => false
      t.integer :cliente_contato_id, :null => false
      t.integer :usuario_responsavel_id, :null => false
      t.integer :tipo_pendencia_id, :null => false
      t.string :titulo,:limit =>60 , :null => false
      t.text :detalhe, :null => false
      t.date :data_previsao_liberacao
      t.datetime :data_hora_real_liberacao
      t.string :versao_liberacao, :limit => 15
      t.string :anexo, :limit => 50

      t.timestamps
    end
    add_index :solicitacoes, :atendimento_id
    add_index :solicitacoes, :status_id
    add_index :solicitacoes, :prioridade_id
    add_index :solicitacoes, :projeto_sub_modulo_id
    add_index :solicitacoes, :cliente_contato_id
    add_index :solicitacoes, :tipo_pendencia_id
    add_index :solicitacoes, :usuario_responsavel_id

    add_foreign_key :solicitacoes, :atendimentos, :name =>"fk_solicitacoes_atendimentos"
    add_foreign_key :solicitacoes, :status, :name =>"fk_solicitacoes_status"
    add_foreign_key :solicitacoes, :prioridades, :name =>"fk_solicitacoes_prioridades"
    add_foreign_key :solicitacoes, :projeto_sub_modulos, :name =>"fk_solicitacoes_projeto_sub_modulos"
    add_foreign_key :solicitacoes, :cliente_contatos, :name =>"fk_solicitacoes_cliente_contatos_id"
    add_foreign_key :solicitacoes, :tipo_pendencias, :name =>"fk_solicitacoes_tipo_pendencias"
    add_foreign_key :solicitacoes, :usuarios,:column => "usuario_responsavel_id",:name => "fk_pendencias_itens_usuario_responsavel"

  end

  def self.down
    drop_table :solicitacoes
  end
end
