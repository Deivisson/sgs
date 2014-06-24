module CompromissosHelper
	def css_class_for_compromisso_style(compromisso)
		if compromisso.has_treinamento?
			"compromisso-treinamento"
		else
			"compromisso-default"
		end
	end
end
