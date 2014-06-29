module ClienteInfrasHelper
	def options_for_categoria_servidor
		options = []
		options << ["Dedicado",ClienteInfra::CATEGORIA_SERVIDOR_DEDICADO]
		options << ["Compartilhado",ClienteInfra::CATEGORIA_SERVIDOR_COMPARTILHADO]
		options << ["Nuvem",ClienteInfra::CATEGORIA_SERVIDOR_NUVEM]
		return options
	end

	def options_for_tipo_servidor
		options = []
		options << ["Montado",ClienteInfra::TIPO_SERVIDOR_MONTADO]
		options << ["Pronto",ClienteInfra::TIPO_SERVIDOR_PRONTO]
		return options
	end
end
