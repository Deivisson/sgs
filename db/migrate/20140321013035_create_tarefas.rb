class CreateTarefas < ActiveRecord::Migration
  def change
    create_table :tarefas do |t|
      t.references :usuario
      t.references :solicitacao
      t.datetime :data_hora_inicio
      t.datetime :data_hora_fim
      t.timestamps
    end
    add_index :tarefas, :usuario_id
    add_foreign_key :tarefas, :usuarios, :name => "tarefas_usuarios"
    add_foreign_key :tarefas, :solicitacoes, :name => "tarefas_solicitacoes"
  end
end
