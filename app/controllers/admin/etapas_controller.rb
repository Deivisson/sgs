class EtapasController < ApplicationController
  def index
    @etapas = Etapa.all
    respond_with(@etapas)
  end

  def show
    @etapa = Etapa.find(params[:id])
    respond_with(@etapa)
  end

  def new
    @etapa = Etapa.new
    respond_with(@etapa)
  end

  def edit
    @etapa = Etapa.find(params[:id])
  end

  def create
    @etapa = Etapa.new(params[:etapa])
    @etapa.save
    respond_with(@etapa)
  end

  def update
    @etapa = Etapa.find(params[:id])
    @etapa.update_attributes(params[:etapa])
    respond_with(@etapa)
  end

  def destroy
    @etapa = Etapa.find(params[:id])
    @etapa.destroy
    respond_with(@etapa)
  end
end
