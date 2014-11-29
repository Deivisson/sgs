# -*- encoding : utf-8 -*-
class Usuario::SolicitacaoPesquisasController < Usuario::BaseController

  layout "full_layout"
  def index
    @params = params
    @params = session[:params_pesquisa] unless params["local"].present? && params[:local] == "pesquisa_form"
    @solicitacoes = [] 
    carrega_solicitacoes if @params.present?
    respond_to do |format|
      format.html
      format.pdf {render :layout => true}
    end
  end

  def new
    carrega_dados
  end

  def carrega_solicitacoes
    @solicitacoes = Solicitacao.listagem("").includes(:usuario_responsavel)
    @solicitacoes = @solicitacoes.where("solicitacoes.cliente_id in(?)",@params[:cliente_ids]) if @params[:cliente_ids].present? 
    @solicitacoes = @solicitacoes.where("categoria_cliente_id in(?)",@params[:categoria_cliente_id]) if @params[:categoria_cliente_id].present? 
    @solicitacoes = @solicitacoes.where("cliente_contato_id in(?)",@params[:solicitante_ids]) if @params[:solicitante_ids].present?
    @solicitacoes = @solicitacoes.where("usuario_cadastrante_id in(?)",@params[:cadastrante_ids]) if @params[:cadastrante_ids].present? 
    @solicitacoes = @solicitacoes.where("usuario_responsavel_id in(?)",@params[:usuario_ids]) if @params[:usuario_ids].present? 
    @solicitacoes = @solicitacoes.where("solucoes.id in(?)",@params[:solucao_ids]) if @params[:solucao_ids].present? 
    @solicitacoes = @solicitacoes.where("solucao_modulos.id in(?)",@params[:modulo_ids]) if @params[:modulo_ids].present?
    @solicitacoes = @solicitacoes.where("solucao_sub_modulos.id in(?)",@params[:sub_modulo_ids]) if @params[:sub_modulo_ids].present?
    @status = nil
    if @params[:status_ids].present?
      @status = Status.find(@params[:status_ids])
      @solicitacoes = @solicitacoes.where("status_id in(?)",@params[:status_ids])
    end
    @solicitacoes = @solicitacoes.where("prioridade_id in(?)",@params[:prioridade_ids]) if @params[:prioridade_ids].present?
    @solicitacoes = @solicitacoes.where("tipo_pendencia_id in(?)",@params[:tipo_ids]) if @params[:tipo_ids].present?
    session[:params_pesquisa] = @params
  end

private

  def carrega_dados
    @clientes = Cliente.order(:nome)
    @usuarios = Usuario.where("id > 1").order(:nome)
    @solucoes = Solucao.all #.order(:description)
    @modulos = []#SolucaoModulo.order(:descricao)
    @sub_modulos = []#SolucaoSubModulo.all
    @status = Status.all
    @prioridades = Prioridade.all
    @tipo_pendencias = TipoPendencia.find(:all)
    @categoria_clientes = CategoriaCliente.order(:descricao)
  end
end
