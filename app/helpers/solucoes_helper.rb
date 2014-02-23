module SolucoesHelper
	def monta_arvore_solucoes(solucao=nil,show_project_label=true)
		@solucoes = Solucao.includes(:solucao_modulos => :solucao_sub_modulos).order("descricao")
		@solucoes = @solucoes.where("solucoes.id = ?",solucao.id) unless solucao.nil?
		html = []
		@solucoes.each do |s|
			html << content_tag(:ul,class:'solucoes')  do 
				inner_html = []
				if show_project_label
					inner_html << check_box_tag("cliente[solucao_ids][]", s.id,false, id:"solucao-id-#{s.id}")
					inner_html << content_tag(:label, s.descricao,{for:"solucao-id-#{s.id}",class:"check-label solucao-label"})
				end
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
				inner_html << check_box_tag("cliente[modulos_ids][]", m.id,false, 
											id:"solucao-modulo-id-#{m.id}",class:'modulo-checkbox',parent:"solucao-id-#{solucao.id}")
				inner_html << content_tag(:label, m.descricao,{for:"modulo-id-#{m.id}",class:"check-label modulo-label"})

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
				inner_html << check_box_tag("cliente[sub_modulos_ids][]", sm.id,false, 
									id:"solucao-submodulo-id-#{sm.id}",parent:"solucao-modulo-id-#{modulo.id}")

				inner_html << content_tag(:label, sm.descricao,{:for => "solucao-sub-modulo-id-#{sm.id}"})
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

end