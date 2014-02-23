class AddCamposToSolucaoSubModulos < ActiveRecord::Migration
  def change
  	add_column :solucao_sub_modulos, :previsao_treinamento_minutos, :integer
  	add_column :solucao_sub_modulos, :peso, :integer
  end
end
