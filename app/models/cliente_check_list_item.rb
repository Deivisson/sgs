class ClienteCheckListItem < ActiveRecord::Base

	DISPONIVEL_SIM = 1
	DISPONIVEL_NAO = 0

	RESPONSAVEL_CLIENTE = 1
	RESPONSAVEL_SIEMATEC = 2
	
	validates :motivo, presence:true, :if => Proc.new {|c| !c.disponivel? && !c.new_record?}
	validates :data_prevista, presence:true, :if => Proc.new {|c| !c.disponivel? && !c.new_record? }

  belongs_to :check_list_item
  belongs_to :cliente
  #attr_accessible :data_prevista, :disponivel, :motivo, :nome_responsavel, :responsavel

end
