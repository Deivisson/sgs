# -*- encoding : utf-8 -*-
module ClienteCheckListItensHelper
	def options_for_disponivel
		options = []
		options << ["Sim",ClienteCheckListItem::DISPONIVEL_SIM]
		options << ["Não",ClienteCheckListItem::DISPONIVEL_NAO]
		return options
	end

	def options_for_responsavel
		options = []
		options << ["Cliente",ClienteCheckListItem::RESPONSAVEL_CLIENTE]
		options << ["Siematec",ClienteCheckListItem::RESPONSAVEL_SIEMATEC]
		return options
	end
end
