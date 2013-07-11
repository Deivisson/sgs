# -*- encoding : utf-8 -*-
class Admin::SolucaoSubModulosController < Admin::BaseController
  def index
    @solucao_sub_modulos = SolucaoSubModulo.joins(:solucao_modulo => :solucao)
    @solucao_sub_modulos = @solucao_sub_modulos.select("solucao_sub_modulos.id,solucoes.descricao as solucao,solucao_sub_modulos.descricao as sub_modulo,solucao_modulos.descricao as modulo")
    @solucao_sub_modulos = @solucao_sub_modulos.paginate(:page => params['page'], :per_page =>20)
    @solucao_sub_modulos = @solucao_sub_modulos.order("solucoes.id, solucao_modulo_id Desc, solucao_sub_modulos.id Desc")
  end

  def show
    @solucao_sub_modulo = SolucaoSubModulo.find(params[:id])
    @local = params[:local] if params[:local]
  end

  def new
    @solucao_sub_modulo = SolucaoSubModulo.new
    @solucao_sub_modulo.solucao_modulo_id = params[:solucao_modulo] if params[:solucao_modulo]
    @solucoes = Solucao.to_select if not params[:solucao_modulo]
    @local = params[:local] if params[:local]
  end

  def create
    @solucao_sub_modulo = SolucaoSubModulo.new(params[:solucao_sub_modulo])
    if @solucao_sub_modulo.save
      flash[:notice] = "Sub Módulo cadastrado com sucesso."
      redirect_to [:admin, @solucao_sub_modulo.solucao_modulo]
    else
      render :action => 'new'
    end
  end

  def edit
    @solucao_sub_modulo = SolucaoSubModulo.find(params[:id])
    @local = params[:local] if params[:local]
  end

  def update
    @solucao_sub_modulo = SolucaoSubModulo.find(params[:id])
    if @solucao_sub_modulo.update_attributes(params[:solucao_sub_modulo])
      flash[:notice] = "Sub Módulo atualizado com sucesso."
      redirect_to [:admin, @solucao_sub_modulo]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @solucao_sub_modulo = SolucaoSubModulo.find(params[:id])
      @solucao_sub_modulo.destroy
      flash[:notice] = "Sub Módulo excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para o sub módulo."
    ensure
      redirect_to admin_solucao_sub_modulos_url
    end
  end
end
