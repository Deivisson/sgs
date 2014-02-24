class CreateStatusTempoEvolucoes < ActiveRecord::Migration
  def change
    create_table :status_tempo_evolucoes do |t|
      t.references :status, :null => false
      t.references :tipo_pendencia, :null => false
      t.references :prioridade, :null => false
      t.integer :tempo_minutos, :null => false

      t.timestamps
    end
    add_index :status_tempo_evolucoes, :status_id
    add_index :status_tempo_evolucoes, :tipo_pendencia_id
    add_index :status_tempo_evolucoes, :prioridade_id
    add_foreign_key :status_tempo_evolucoes, :status, :name => "status_tempo_evolucoes_status"
    add_foreign_key :status_tempo_evolucoes, :tipo_pendencias, :name => "status_tempo_evolucoes_tipo_pendencias"
    add_foreign_key :status_tempo_evolucoes, :prioridades, :name => "status_tempo_evolucoes_prioridades"
  end
end
