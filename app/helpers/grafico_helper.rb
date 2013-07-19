module GraficoHelper
	def plota_grafico(params={})
		perc = params[:perc]
		super_html = []
		super_html << content_tag(:div,class:grafico_container(perc)) do 
			html = []
			html << "#{perc}%"
			html << content_tag(:div, class:grafico_css_class(perc), style:"width:#{perc}%") do 
				#inner_html = []
				#inner_html.join.html_safe
			end
			html.join.html_safe
		end
		super_html.join.html_safe
	end

private
	
	def grafico_css_class(perc)
		return  case perc
						when 0..10   then "grafico sem-progresso comprometido"
						when 11..30  then "grafico em-alerta"
						when 31..90  then "grafico noprazo"	
						when 91..100 then "grafico concluindo"
						end
	end

	def grafico_container(perc)
		return case perc
					 when 0 then "grafico-container sem-progresso"
					 else "grafico-container"
					 end
	end

end