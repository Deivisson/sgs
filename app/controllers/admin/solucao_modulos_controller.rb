# -*- encoding : utf-8 -*-
class Admin::SolucaoModulosController < Admin::BaseController

  def index
    @solucao_modulos = SolucaoModulo.lista_modulos
  end

  def show
    @solucao_modulo = SolucaoModulo.find(params[:id])
    @solucao_sub_modulos = SolucaoSubModulo.where(solucao_modulo_id:@solucao_modulo.id).order(:ordem)
    @local = params[:local] if params[:local]
  end

  def new
    @solucao_modulo = SolucaoModulo.new
    @solucao_modulo.solucao_id = params[:solucao] if params[:solucao]
    @solucoes = Solucao.to_select if not params[:solucao]
    @local = params[:local] if params[:local]
  end

  def create
    @solucao_modulo = SolucaoModulo.new(params[:solucao_modulo])
    if @solucao_modulo.save
      flash[:notice] = "Módulo cadastrado com sucesso."
      redirect_to [:admin,@solucao_modulo]
    else
      render :action => 'new'
    end
  end

  def edit
    @solucao_modulo = SolucaoModulo.find(params[:id])
    @local = params[:local] if params[:local]
  end

  def update
    @solucao_modulo = SolucaoModulo.find(params[:id])
    if @solucao_modulo.update_attributes(params[:solucao_modulo])
      flash[:notice] = "Módulo atualizado com sucesso."
      redirect_to [:admin, @solucao_modulo]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @solucao_modulo = SolucaoModulo.find(params[:id])
      @solucao_modulo.destroy
      flash[:notice] = "Módulo deletado com sucesso."
    rescue
       flash[:warning] = "Exclusão não permitida para este módulo."
    ensure
      redirect_to admin_solucao_modulos_url
    end
  end

  def ordenar
    @solucao_id = params[:solucao_id]
    @solucao_modulos = SolucaoModulo.where(solucao_id:@solucao_id).order("ordem")
  end

  def atualiza_ordem
    i = 0
    params[:ordem].each do |id|
      SolucaoModulo.update_all("ordem=#{i}",["id = ?",id])
      i += 1
    end
    flash[:notice] = "Ordenação realizada com sucesso."
    redirect_to admin_solucao_path(params[:solucao_id])
  end  
end
