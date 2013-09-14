module SolucoesHelper
	def monta_arvore_solucoes
		@solucoes = Solucao.includes(:solucao_modulos => :solucao_sub_modulos).order("descricao")
		html = []
		@solucoes.each do |s|
			html << content_tag(:ul,class:'solucoes')  do 
				inner_html = []
				inner_html << check_box_tag("cliente[solucao_ids][]", s.id,false, :id => "solucao-id-#{s.id}")
				inner_html << content_tag(:label, s.descricao,{:for => "solucao-id-#{s.id}",:class => "check-label"})
				inner_html << modulos(s)
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

	def modulos(solucao)
		html = []
		solucao.solucao_modulos.each do |m|
			html << content_tag(:ul,class:'solucao_modulo') do 
				inner_html = []
				inner_html << m.descricao
				inner_html << sub_modulos(m)
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

	def sub_modulos(modulo)
		html = []
		modulo.solucao_sub_modulos.each do |sm|
			html << content_tag(:li)  do 
				inner_html = []
				inner_html << check_box_tag("cliente[sub_modulos_ids][]", sm.id,false, :id => "solucao-sub-modulo-id-#{sm.id}")
				inner_html << content_tag(:label, sm.descricao,{:for => "solucao-sub-modulo-id-#{sm.id}"})
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

end