class CreateEtapasProjetos < ActiveRecord::Migration
  def change
    create_table :etapas_projetos do |t|
      t.integer :etapa_id
      t.integer :projeto_id
      t.timestamps
    end
    add_index :etapas_projetos, :etapa_id
    add_index :etapas_projetos, :projeto_id
    add_foreign_key :etapas_projetos, :etapas, :name => "fk_etapas_projetos_etapas"
    add_foreign_key :etapas_projetos, :projetos, :name => "fk_etapas_projetos_projetos"
  end
end
