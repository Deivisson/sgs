class AddLocalTreinamentoColumnToProjetoProgramacaoTreinamento < ActiveRecord::Migration
  def change
    add_column :projeto_programacao_treinamentos, :local_treinamento, :integer, null:false, default:0
  end
end
