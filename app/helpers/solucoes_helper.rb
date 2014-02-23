module SolucoesHelper
	def monta_arvore_solucoes(solucao=nil,options={})
		exibir_nome_solucao			= options[:exibir_nome_solucao] || true
 		solucao_ids   					= options[:solucao_ids] 	|| []
		@sub_modulo_ids					= options[:sub_modulo_ids]|| []
		@modulo_ids							= options[:modulo_ids]		|| []
		@modo_consulta  				= options[:modo_consulta] || false 
		@todos  								= options[:todos].nil? ? true : options[:todos]

		@solucoes = Solucao.includes(:solucao_modulos => :solucao_sub_modulos).order("descricao")
		@solucoes = @solucoes.where("solucoes.id = ?",solucao.id) unless solucao.nil?
		html = []
		@solucoes.each do |s|
			html << content_tag(:ul,class:'solucoes')  do 
				inner_html = []
				if exibir_nome_solucao && (@todos || solucao_ids.include?(s.id))
					inner_html << check_box_tag("cliente[solucao_ids][]", s.id,
												solucao_ids.include?(s.id), id:"solucao-id-#{s.id}") unless @modo_consulta
					inner_html << content_tag(:label, s.descricao,{for:"solucao-id-#{s.id}",
												class:"check-label solucao-label"})
				end
				inner_html << modulos(s) if (@todos || solucao_ids.include?(s.id))
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
				if (@todos || @modulo_ids.include?(m.id))
					inner_html << check_box_tag("", m.id,@modulo_ids.include?(m.id), 
												id:"solucao-modulo-id-#{m.id}",class:'modulo-checkbox',
												parent:"solucao-id-#{solucao.id}") unless @modo_consulta
					inner_html << content_tag(:label, m.descricao,{for:"solucao-modulo-id-#{m.id}",class:"check-label modulo-label"})
				end
				inner_html << sub_modulos(m) if (@todos || @modulo_ids.include?(m.id))
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
				if (@todos || @sub_modulo_ids.include?(sm.id))
					inner_html << check_box_tag("cliente[solucao_sub_modulo_ids][]", sm.id,
											@sub_modulo_ids.include?(sm.id), id:"solucao-submodulo-id-#{sm.id}",
											parent:"solucao-modulo-id-#{modulo.id}") unless @modo_consulta
					inner_html << content_tag(:label, sm.descricao,{for:"solucao-submodulo-id-#{sm.id}"})
				end
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

end