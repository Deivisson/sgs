# -*- encoding : utf-8 -*-
class Usuario::SolicitacaoHistoricosController < Usuario::BaseController

  def show
    @solicitacao_historico = SolicitacaoHistorico.find(params[:id])
    @local = params[:local] if params[:local]
  end

  def edit
    @solicitacao_historico = SolicitacaoHistorico.find(params[:id])
    @local = params[:local] if params[:local]
  end

  def update
    @solicitacao_historico = SolicitacaoHistorico.find(params[:id])
    if @solicitacao_historico.update_attributes(params[:solicitacao_historico])
      flash[:notice] = "Histórico atualizado com sucesso."
    end
    respond_with(@solicitacao_historico)
  end

  def destroy
    begin
      @solicitacao_historico = SolicitacaoHistorico.find(params[:id])
      @solicitacao_historico.destroy
      flash[:notice] = "Histórico excluído com sucesso."
    rescue
      flash[:notice] = "Exclusão não permitida para este histórico."
    ensure
      redirect_to [:usuario, @solicitacao_historico.solicitacao]
    end
  end

end
