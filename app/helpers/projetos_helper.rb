# -*- encoding : utf-8 -*-
module ProjetosHelper
	def options_for_frequencia
		{
			"Diário"  	=> Projeto::DIARIO,
			"Semanal" 	=> Projeto::SEMANAL,
			"Quinzenal" => Projeto::QUINZENAL,
			"Mensal"  	=> Projeto::MENSAL
		}
	end
end
