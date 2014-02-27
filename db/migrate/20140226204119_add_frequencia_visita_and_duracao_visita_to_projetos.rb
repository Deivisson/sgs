class AddFrequenciaVisitaAndDuracaoVisitaToProjetos < ActiveRecord::Migration
  def change
  	add_column :projetos, :frequencia_visita, :integer
  	add_column :projetos, :duracao_visita_minutos, :integer
  end
end
