module GraficoHelper
	def plota_grafico(params={})
		perc = params[:perc]
		html = []
		html << content_tag(:div, class:grafico_css_class(perc), style:"width:#{perc}%") do 
			inner_html = []
			inner_html << "#{perc}%"
			inner_html.join.html_safe
		end
		html.join.html_safe
	end

private
	
	def grafico_css_class(perc)
		return  case perc
						when 0..10   then "grafico comprometido"
						when 11..30  then "grafico em-alerta"
						when 31..90  then "grafico noprazo"	
						when 91..100 then "grafico concluindo"
						end
	end

end