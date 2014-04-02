module TarefasHelper
	def duracao_tarefa(tarefa)
	  html = ""
	  count = tarefa.periodo_duracao.size
	  if count > 1
	    html = content_tag(:span,"", style:"width: #{count * 120}px; #{prioridade_style(tarefa.solicitacao.prioridade)}")
	  end
	 return html.html_safe
	end

	def prioridade_style(prioridade,show_border=true,options={})
		unless prioridade.nil?
			options.merge!(:bg_color 			=> prioridade.background_color)
			options.merge!(:border_color 	=> prioridade.border_color)
			options.merge!(:font_color 		=> prioridade.font_color)
		end
		html = []
		html << "background-color: #{options[:bg_color]}"
		html << "color: #{options[:font_color]}"
		html << "border: 1px solid #{options[:border_color]}" if show_border
		html.join(";").html_safe
	end
end