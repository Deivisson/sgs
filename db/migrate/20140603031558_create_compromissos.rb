class CreateCompromissos < ActiveRecord::Migration
  def change
    create_table :compromissos do |t|
      t.date :data_inicio, :null => false
      t.time :hora_inicio, :null => false
      t.date :data_fim
      t.time :hora_fim
      t.references :usuario, :null => false
      t.text :descricao, :null => false
      t.integer :usuario_cadastrante_id, :null => false
      t.integer :projeto_programacao_treinamento_id
      t.integer :status, :null => false
      t.timestamps
    end
    add_foreign_key :compromissos, :usuarios, name:'compromissos_usuarios'
    add_foreign_key :compromissos, :usuarios,:column => "usuario_cadastrante_id",:name => "compromissos_usuario_cadastrante"
    add_foreign_key :compromissos, :projeto_programacao_treinamentos, name:'compromissos_projeto_programacao_treinamentos'
  end
end
