# -*- encoding : utf-8 -*-
class Admin::ConsultasController < Admin::BaseController

  def index
    @consultas = Consulta.all(:order => :descricao)
  end

  def show
    @consultas = Consulta.find(params[:id])
  end

  def new
    @consultas = Consulta.new
  end

  def create
    @consultas = Consulta.new(params[:consultas])
    if @consultas.save
      flash[:notice] = "Consulta cadastrada com sucesso."
      redirect_to [:admin,@consultas]
    else
      render :action => 'new'
    end
  end

  def edit
    @consultas = Consulta.find(params[:id])
  end

  def update
    @consultas = Consulta.find(params[:id])
    if @consultas.update_attributes(params[:consultas])
      flash[:notice] = "Consulta atualizada com sucesso."
      redirect_to [:admin,@consultas]
    else
      render :action => 'edit'
    end
  end

  def destroy
    @consultas = Consulta.find(params[:id])
    @consultas.destroy
    flash[:notice] ="Consulta excluída com sucesso."
    redirect_to admin_consultas_url
  end
end
