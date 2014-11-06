# -*- encoding : utf-8 -*-
class Admin::UsuariosController < Admin::BaseController
  
  before_filter :carrega_solucoes, :only => [:new,:edit,:create, :update]
  
  def index
    @usuarios = Usuario.all(:conditions => ["id > 1"])
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      flash[:notice] = "Usuário cadastrado com sucesso."
      redirect_to [:admin, @usuario]
    else
      render :action => 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(params[:usuario])
      flash[:notice] = "Usuário atualizado com sucesso."
      redirect_to [:admin, @usuario]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @usuario = Usuario.find(params[:id])
      @usuario.delete
      flash[:notice] = "Usuário excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este usuário. Caso necessário pode ser realizado a substituição do mesmo."
    ensure
      redirect_to admin_usuarios_url
    end
  end

  def pre_replace
    @usuario = Usuario.find(params[:usuario_id])
    @usuarios = Usuario.where("id <> ? and  id > 1",@usuario.id)
    @usuarios = @usuarios.order(:nome)
  end

  def replace
    begin
      @usuario = Usuario.find(params[:usuarios][:replace_from])
      @usuario.usuario_substituto = Usuario.find(params[:usuarios][:replace_to])
      @usuario.destroy
      flash[:notice] = "Usuário excluído/substiuído com sucesso."
      redirect_to admin_usuarios_url  
    rescue Exception => e
      flash[:warning] = "Exclusão/Substituição não realizada.: #{e}"      
      redirect_to [:admin, @usuario]
    end
  end

private 

  def carrega_solucoes
    @solucoes = Solucao.to_select
  end
end
