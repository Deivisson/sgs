# -*- encoding : utf-8 -*-
class Usuario::CadastrosBasicosController < Usuario::BaseController
	layout 'cadastros_basicos'
	before_filter :set_current_menu
	def index
		
	end

	private

	def set_current_menu
		session[:current_menu] = "cadastros_basicos"
	end
end