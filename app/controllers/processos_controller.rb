class ProcessosController < ApplicationController
  def index
    @processos = Processo.all
    respond_with(@processos)
  end

  def show
    @processo = Processo.find(params[:id])
    respond_with(@processo)
  end

  def new
    @processo = Processo.new
    respond_with(@processo)
  end

  def edit
    @processo = Processo.find(params[:id])
  end

  def create
    @processo = Processo.new(params[:processo])
    @processo.save
    respond_with(@processo)
  end

  def update
    @processo = Processo.find(params[:id])
    @processo.update_attributes(params[:processo])
    respond_with(@processo)
  end

  def destroy
    @processo = Processo.find(params[:id])
    @processo.destroy
    respond_with(@processo)
  end
end
