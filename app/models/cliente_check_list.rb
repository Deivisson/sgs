class ClienteCheckList < ActiveRecord::Base
  belongs_to :check_list_item
  belongs_to :cliente
  #attr_accessible :data_prevista, :disponivel, :motivo, :nome_responsavel, :responsavel
end
