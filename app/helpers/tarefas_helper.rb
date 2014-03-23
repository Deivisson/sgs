module TarefasHelper
	def duracao_tarefa(tarefa)
	  html = ""
	  count = tarefa.periodo_duracao.size
	  if count > 1
	    html = content_tag(:span,"", style:"width: #{count * 120}px; #{prioridade_style(tarefa.solicitacao.prioridade)}")
	  end
	 return html.html_safe
	end

	def prioridade_style(prioridade,show_border=true)
		html = []
		html << "background-color: #{prioridade.background_color}"
		html << "color: #{prioridade.font_color}"
		html << "border: 1px solid #{prioridade.border_color}" if show_border
		html.join(";").html_safe
	end
end