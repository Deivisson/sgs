class CreateProjetoProgramacaoTreinamentosSolucaoSubModulos < ActiveRecord::Migration
  def change
    create_table :projeto_programacao_treinamentos_solucao_sub_modulos, id:false do |t|
      t.references :projeto_programacao_treinamento
      t.references :solucao_sub_modulo
      t.timestamps
    end
    add_foreign_key :projeto_programacao_treinamentos_solucao_sub_modulos, :projeto_programacao_treinamentos, name:'projeto_programacao_treinamentos'
    add_foreign_key :projeto_programacao_treinamentos_solucao_sub_modulos, :solucao_sub_modulos, name:'programacao_treinamentos_solucao_sub_modulos'
  end
end
