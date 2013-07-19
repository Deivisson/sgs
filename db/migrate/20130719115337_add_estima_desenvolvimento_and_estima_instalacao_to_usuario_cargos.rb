class AddEstimaDesenvolvimentoAndEstimaInstalacaoToUsuarioCargos < ActiveRecord::Migration
  def change
    add_column :usuario_cargos, :estima_desenvolvimento, :boolean, :null => false,:default => false
    add_column :usuario_cargos, :estima_instalacao, :boolean, :null => false, :default => false
  end
end
