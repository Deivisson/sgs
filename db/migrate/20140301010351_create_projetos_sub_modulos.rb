class CreateProjetosSubModulos < ActiveRecord::Migration
  def change
    create_table :projetos_sub_modulos do |t|
      t.references :projeto
      t.references :solucao_sub_modulo
      t.timestamps
    end
    add_index :projetos_sub_modulos, :projeto_id
    add_index :projetos_sub_modulos, :solucao_sub_modulo_id

    add_foreign_key :projetos_sub_modulos, :projetos, :name => "projetos_sub_modulos_projetos"
    add_foreign_key :projetos_sub_modulos, :solucao_sub_modulos, :name => "projetos_sub_modulos_solucao_sub_modulo"
  end
end
