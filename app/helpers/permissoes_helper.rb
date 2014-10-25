module PermissoesHelper
	def montar_permissoes(usuario_cargo)
		@permissao_ids = usuario_cargo.permissao_ids
		@permissoes = Permissao.order("parent_id,descricao")
		html = []
		html << content_tag(:ul,class:'permissao-list') do
			inner_html = []
			@permissoes.each do |permissao|
				if permissao.parent_id.nil?
						inner_html << content_tag(:li) do
							html1 = []
							html1 << check_box_tag('usuario_cargo[permissao_ids][]',
														permissao.id, @permissao_ids.include?(permissao.id),
														id:"permissao-group-#{permissao.id}")
							html1 << content_tag(:h1,permissao.descricao) 
							html1 << permissoes_itens(permissao.id)
							html1.join.html_safe
						end
				end
			end
			inner_html.join.html_safe
		end
		html.join.html_safe
	end

	def permissoes_itens(parent_id)
		html = []
		html2 = []
		html << content_tag(:ul) do 
			Permissao.order("parent_id,descricao").each do |permissao|
				html2 << content_tag(:li) do
					inner_html = []
					inner_html << check_box_tag('usuario_cargo[permissao_ids][]',
																			permissao.id, @permissao_ids.include?(permissao.id),
																			id:"permissao-#{permissao.id}")
					inner_html << content_tag(:label,permissao.descricao,for:"permissao-#{permissao.id}")
					inner_html.join.html_safe
				end if parent_id == permissao.parent_id
			end
			html2.join.html_safe
		end
		html.join.html_safe
	end

  def possui_permissao?(chave)
    current_usuario.send("permission_#{chave.to_s}?")
  end

  def permissao_usuario!(chave)
    redirect_to usuario_permission_index_path unless possui_permissao?(chave)
  end
end