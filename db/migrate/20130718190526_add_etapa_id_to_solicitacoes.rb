class AddEtapaIdToSolicitacoes < ActiveRecord::Migration
  def change
    add_column :solicitacoes, :etapa_id, :integer
    add_index :solicitacoes, :etapa_id
  	add_foreign_key :solicitacoes, :etapas, :name => "fk_solicitacoes_etapas"
  end

end
