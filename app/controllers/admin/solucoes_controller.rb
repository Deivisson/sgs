# -*- encoding : utf-8 -*-
class Admin::SolucoesController < Admin::BaseController
  before_filter :load_check_list_items, :only => [:new,:edit, :create, :update]

  def index
    @solucoes = Solucao.all(:order => "ordem asc")
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

  def ordenar
    @solucoes = Solucao.all(:order => "ordem")
  end

  def atualiza_ordem
    #@solucoes = Solucao.where(id: params[:ordem]).order(params[:ordem])
    i = 1
    # @solucoes.each do |s|
    #   s.update_attribute(:ordem,i)
    #   i += 1
    # end
    params[:ordem].each do |id|
      Solucao.update_all("ordem=#{i}",["id = ?",id])
      i += 1
    end
    flash[:notice] = "Ordenação realizada com sucesso."
    redirect_to admin_solucoes_url
  end

private 
  def load_check_list_items
    @check_list_items = CheckListItem.all
  end
end
