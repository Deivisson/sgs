# -*- encoding : utf-8 -*-
class Usuario::VersaoSistemasController < Usuario::BaseController

  def index
    @versao_sistemas = VersaoSistema.all(:order => 'id desc')
  end

  def new
    @versao_sistema = VersaoSistema.new
  end

  def show
    @versao_sistema = VersaoSistema.find(params[:id])
    usuario_config = UsuarioConfig.find_by_usuario_id(current_usuario.id);
    usuario_config.update_attributes(:versao_sistema_id => @versao_sistema.id)
  end

  def create
    @versao_sistema = VersaoSistema.new(params[:versao_sistema])
    if @versao_sistema.save
      flash[:notice] = "Successfully created versao sistema."
      redirect_to @versao_sistema
    else
      render :action => 'new'
    end
  end

  def edit
    @versao_sistema = VersaoSistema.find(params[:id])
  end

  def update
    @versao_sistema = VersaoSistema.find(params[:id])
    if @versao_sistema.update_attributes(params[:versao_sistema])
      flash[:notice] = "Successfully updated versao sistema."
      redirect_to @versao_sistema
    else
      render :action => 'edit'
    end
  end

  def destroy
    @versao_sistema = VersaoSistema.find(params[:id])
    @versao_sistema.destroy
    flash[:notice] = "Successfully destroyed versao sistema."
    redirect_to versao_sistemas_url
  end
end
