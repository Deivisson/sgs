# -*- encoding : utf-8 -*-
class Admin::ConfiguracoesController < Admin::BaseController

  before_filter :carrega_configuracao

  def show; end

  def edit; end

  def update
    @configuracao = Configuracao.find(params[:id])
    if @configuracao.update_attributes(params[:configuracao])
      flash[:notice] = "Atualização realizada com sucesso."
      redirect_to [:admin,@configuracao]
    else
      render :action => 'edit'
    end
  end

private

  def carrega_configuracao
    @configuracao = Configuracao.find(params[:id])
  end

 end
