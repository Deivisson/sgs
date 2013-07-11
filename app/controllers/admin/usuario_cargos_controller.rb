# -*- encoding : utf-8 -*-
class Admin::UsuarioCargosController <  Admin::BaseController

  def index
    @usuario_cargos = UsuarioCargo.all(:conditions => ["id > 1"],:order => "id Desc")
  end

  def show
    @usuario_cargo = UsuarioCargo.find(params[:id])
  end

  def new
    @usuario_cargo = UsuarioCargo.new
  end

  def create
    @usuario_cargo = UsuarioCargo.new(params[:usuario_cargo])
    if @usuario_cargo.save
      atualiza_status_fluxo(params["status_fluxo"]) if params["status_fluxo"]

      flash[:notice] = "Cargo cadastrado com sucesso."
      redirect_to  admin_usuario_cargos_path
    else
      render :action => 'new'
    end
  end

  def edit
    @usuario_cargo = UsuarioCargo.find(params[:id])
  end

  def update
    @usuario_cargo = UsuarioCargo.find(params[:id])
    if @usuario_cargo.update_attributes(params[:usuario_cargo])
      atualiza_status_fluxo(params["status_fluxo"]) if params["status_fluxo"]

      flash[:notice] = "Cargo atualizado com sucesso."
      redirect_to [:admin, @usuario_cargo]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @usuario_cargo = UsuarioCargo.find(params[:id])
      @usuario_cargo.destroy
      flash[:notice] = "Cargo excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este cargo."
    ensure
      redirect_to admin_usuario_cargos_url
    end
  end

  #Responsavel por atualizar o fluxo do status
  def atualiza_status_fluxo(status_fluxo)
    status_fluxo.each do |status,itens|
      @fluxos = ''
      itens.each{|item| @fluxos += "#{',' if not @fluxos.empty?}#{item}" }
      StatusUsuarioCargo.atualiza_status_fluxo(@usuario_cargo.id,eval(status),@fluxos)
    end
  end
end
