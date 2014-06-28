class ClienteInfra < ActiveRecord::Base
  attr_accessible :banco_dados, :email, :nome_empresa_ti, :numero_estacoes, :observacao, :responsavel_ti, :servidor_com_ride, :sistema_operacional, :solucao_backup, :telefone, :tipo_servidor, :tipo_servidor

  belongs_to :cliente

end
