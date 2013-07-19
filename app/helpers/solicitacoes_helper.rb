module SolicitacoesHelper
	def options_for_nivel_complexidade
		options = []
		options << ["Baixa",Solicitacao::COMPLEXIDADE_BAIXA]
		options << ["Media",Solicitacao::COMPLEXIDADE_MEDIA]
		options << ["Alta",Solicitacao::COMPLEXIDADE_ALTA]
		return options
	end
end