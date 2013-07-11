# -*- encoding : utf-8 -*-
class Admin::UsuarioConfigsController <  Admin::BaseController

  def edit
    @usuario_config = UsuarioConfig.find_by_usuario_id(current_usuario.id)
  end

  def update
    @usuario_config = UsuarioConfig.find(params[:id])
    if @usuario_config.update_attributes(params[:usuario_config])
      flash[:notice] = "Configurações do usuário gravadas com sucesso."
      redirect_to :controller => 'solicitacoes', :action => 'index'
    end
  end
end
