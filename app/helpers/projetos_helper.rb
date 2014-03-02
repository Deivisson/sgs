# -*- encoding : utf-8 -*-
module ProjetosHelper
	def options_for_frequencia
		{
			"Diário"  	=> Projeto::DIARIO,
			"Semanal" 	=> Projeto::SEMANAL,
			"Quinzenal" => Projeto::QUINZENAL,
			"Mensal"  	=> Projeto::MENSAL
		}
	end

	#
	def monta_solucoes_projeto_treinamento(solucao=nil,options={})
 		solucao_ids   					= options[:solucao_ids] 	|| []
		@sub_modulo_ids					= options[:sub_modulo_ids]|| []
		@modulo_ids							= options[:modulo_ids]		|| []

		@solucoes = Solucao.includes(:solucao_modulos => :solucao_sub_modulos).order("descricao")
		@solucoes = @solucoes.where("solucoes.id = ?",solucao.id) unless solucao.nil?
		html = []
		@solucoes.each do |s|
			html << content_tag(:ul,class:'projeto-solucoes')  do 
				inner_html = []
				inner_html << content_tag(:label, s.descricao,{for:"solucao-id-#{s.id}",
											class:"check-label solucao-label"})
				inner_html << projeto_modulos(s)
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

private 
	def projeto_modulos(solucao)
		html = []
		solucao.solucao_modulos.each do |m|
			html << content_tag(:ul,class:'projeto-modulo') do 
				inner_html = []
				if @modulo_ids.include?(m.id)
					inner_html << check_box_tag("", m.id,false, 
													id:"solucao-modulo-id-#{m.id}",class:'modulo-checkbox',
													parent:"solucao-id-#{solucao.id}")
					inner_html << content_tag(:div,class:'projeto-modulo-item') do
						item = []
						# item << content_tag(:div,class:'buttons') do
						# 	links = []
						# 	links << link_to(image_tag(image_link[:edit]),"#")
						# 	links << link_to(image_tag(image_link[:del]),"#")
						# 	links.join.html_safe
						# end
						item << content_tag(:label, m.descricao,{for:"solucao-modulo-id-#{m.id}",class:"check-label modulo-label"})
						item.join.html_safe
					end
				end
				inner_html << projeto_sub_modulos(m) if @modulo_ids.include?(m.id)
				inner_html.join.html_safe
			end
		end
		html.join.html_safe
	end

	def projeto_sub_modulos(modulo)
		html = []
		modulo.solucao_sub_modulos.each do |sm|
			html << content_tag(:li)  do 
				inner_html = []
				if @sub_modulo_ids.include?(sm.id)
					inner_html << check_box_tag("solucao_sub_modulo_ids[]", sm.id,
												false, id:"solucao-submodulo-id-#{sm.id}",
												parent:"solucao-modulo-id-#{modulo.id}")
					# inner_html << content_tag(:div,class:'buttons') do
					# 	links = []
					# 	links << link_to(image_tag(image_link[:edit]),"#")
					# 	links << link_to(image_tag(image_link[:del]),"#")
					# 	links.join.html_safe
					# end
					inner_html << content_tag(:label, sm.descricao,{for:"solucao-submodulo-id-#{sm.id}"})
					inner_html.join.html_safe
				end
			end
		end
		html.join.html_safe
	end



end
