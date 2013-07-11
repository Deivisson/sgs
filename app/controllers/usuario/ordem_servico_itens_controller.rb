class OrdemServicoItensController < ApplicationController
  def index
    @ordem_servico_itens = OrdemServicoItem.all
    respond_with(@ordem_servico_itens)
  end

  def show
    @ordem_servico_item = OrdemServicoItem.find(params[:id])
    respond_with(@ordem_servico_item)
  end

  def new
    @ordem_servico_item = OrdemServicoItem.new
    respond_with(@ordem_servico_item)
  end

  def edit
    @ordem_servico_item = OrdemServicoItem.find(params[:id])
  end

  def create
    @ordem_servico_item = OrdemServicoItem.new(params[:ordem_servico_item])
    @ordem_servico_item.save
    respond_with(@ordem_servico_item)
  end

  def update
    @ordem_servico_item = OrdemServicoItem.find(params[:id])
    @ordem_servico_item.update_attributes(params[:ordem_servico_item])
    respond_with(@ordem_servico_item)
  end

  def destroy
    @ordem_servico_item = OrdemServicoItem.find(params[:id])
    @ordem_servico_item.destroy
    respond_with(@ordem_servico_item)
  end
end
