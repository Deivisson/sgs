# -*- encoding : utf-8 -*-
class Admin::SolucoesController < Admin::BaseController

  def index
    @solucoes = Solucao.all(:order => "id Desc")
  end

  def show
    @solucao = Solucao.find(params[:id])
    @solucao_modulos = SolucaoModulo.where(solucao_id:params[:id])
  end

  def new
    @solucao = Solucao.new
  end

  def create
    @solucao = Solucao.new(params[:solucao])
    if  @solucao.save
      flash[:notice] = "Solucao cadastrado com sucesso."
      redirect_to [:admin, @solucao]
    else
      render :action => 'new'
    end
  end

  def edit
    @solucao = Solucao.find(params[:id])
  end

  def update
    @solucao = Solucao.find(params[:id])
    
    if @solucao.update_attributes(params[:solucao])
      flash[:notice] = "Solucao atualizado com sucessso."
      redirect_to [:admin, @solucao]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @solucao = Solucao.find(params[:id])
      @solucao.delete
      flash[:notice] = "Solucao excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este solucao."
    ensure
      redirect_to admin_solucoes_url
    end
  end
end
