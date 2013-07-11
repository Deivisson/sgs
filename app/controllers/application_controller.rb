# -*- encoding : utf-8 -*-
require "application_responder"

class ApplicationController < ActionController::Base

  #before_filter :set_charset ,:verifica_nova_versao
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  self.responder = ApplicationResponder
  respond_to :html,:json, :js, :pdf, :xml #,:prawn

  responders :flash,:http_cache


  def set_charset
    headers["Content-Type"] = "text/html; charset=utf-8"
  end

  def verifica_nova_versao
    #render :controller => 'versao_sistemas', :action => 'index'
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.class.to_s
      when "Usuario"
        usuario_solicitacoes_path
      when "Admin"
        admin_clientes_path
    end
  end
end
