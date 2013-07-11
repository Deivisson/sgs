# -*- encoding : utf-8 -*-
class Admin::PrioridadesController < Admin::BaseController
  def index
    @prioridades = Prioridade.all(:order => "id Desc")
  end

  def show
    @prioridade = Prioridade.find(params[:id])
  end

  def new
    @prioridade = Prioridade.new
  end

  def create
    @prioridade = Prioridade.new(params[:prioridade])
    if @prioridade.save
      flash[:notice] = "Prioridade cadastrada com sucesso."
      redirect_to admin_prioridades_path
    else
      render :action => 'new'
    end
  end

  def edit
    @prioridade = Prioridade.find(params[:id])
  end

  def update
    @prioridade = Prioridade.find(params[:id])
    if @prioridade.update_attributes(params[:prioridade])
      flash[:notice] = "Prioridade atualizada com sucesso."
       redirect_to admin_prioridades_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @prioridade = Prioridade.find(params[:id])
      @prioridade.destroy
      flash[:notice] = "Prioridade excluída com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para a prioridade."
    ensure
     redirect_to admin_prioridades_url
    end
  end
end
