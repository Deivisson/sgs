module CompromissosHelper
	def css_class_for_compromisso_style(compromisso)
		css_class = ""
		if compromisso.has_treinamento?
			css_class = "compromisso-treinamento"
		else
			css_class = "compromisso-default"
		end
		css_class += " compromisso-cancelado " if compromisso.cancelado?
		css_class
	end
end
