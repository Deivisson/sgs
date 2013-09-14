# -*- encoding : utf-8 -*-
class Usuario::OrdemServicosController < Usuario::BaseController

  before_filter :carrega_ordem_servico, :except => [:index,:create,:new, :carrega_solicitacoes]
  before_filter :carrega_dados, :only  => [:new,:edit,:update, :create, :index]
  before_filter :permite_editar_excluir, :only => [:edit, :destroy]  

  def index
    @ordem_servicos = OrdemServico.search(params[:conditions])
    @ordem_servicos = @ordem_servicos.order("data_execucao desc")
    respond_with(@ordem_servicos)
  end

  def show
    #respond_with(@ordem_servico)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrdemServicoPdf.new(@ordem_servico, view_context)
        send_data pdf.render, 
            filename: "ordem_servico_#{@ordem_servico.created_at.strftime("%d/%m/%Y")}.pdf",  
            type: "application/pdf"
        
      end
    end
  end

  def new
    @ordem_servico = OrdemServico.new(
      :tipo_os        => OrdemServico::TREINAMENTO,
      :responsavel    => current_usuario,
      :data_execucao  => Time.new.strftime("%d/%m/%Y")
    )
    respond_with(@ordem_servico)
  end

  def edit;  end

  def create
    @ordem_servico = OrdemServico.new(params[:ordem_servico])
    @ordem_servico.cadastrante = current_usuario
    @ordem_servico.save
    respond_with(@ordem_servico, :location => [:usuario,@ordem_servico])
  end

  def update
    @ordem_servico.update_attributes(params[:ordem_servico])
    respond_with(@ordem_servico, :location => [:usuario,@ordem_servico])
  end

  def destroy
    @ordem_servico.destroy
    respond_with(@ordem_servico, :location => usuario_ordem_servicos_path)
  end

  def carrega_solicitacoes
    @solicitacoes = Solicitacao.joins(:atendimento) 
    @solicitacoes = @solicitacoes.where(:gera_cobranca => true)
    @solicitacoes = @solicitacoes.where("cliente_id = ? and status_id = ?", 
      params[:cliente_id],Status::PUBLICADO
    )
    if params[:ordem_servico_id].to_i > 0
      @solicitacoes = @solicitacoes.where("ordem_servico_id is ? OR ordem_servico_id = ? ", 
        nil, params[:ordem_servico_id]
      )
    else
      @solicitacoes = @solicitacoes.where("ordem_servico_id is null", nil)
    end
    respond_with(@solicitacoes)
  end

private
  
  def carrega_ordem_servico
    @ordem_servico = OrdemServico.find(params[:id])   
  end

  def carrega_dados
    @clientes = Cliente.to_select
    @usuarios = Usuario.to_select
    @tipo_avaliacoes = TipoAvaliacao.all
    @situacoes = Situacao.all
    
    carrega_contatos_e_solucoes_do_cliente

  end

  def carrega_contatos_e_solucoes_do_cliente
    if !@ordem_servico.nil? && @ordem_servico.cliente_id.present?
      @cliente_contatos = ClienteContato.to_select_by_cliente(@ordem_servico.cliente_id)
      @solucoes = Solucao.to_select_by_cliente(@ordem_servico.cliente_id)

    elsif params[:ordem_servico].present? && params[:ordem_servico][:cliente_id].present?
      @cliente_contatos = ClienteContato.to_select_by_cliente(params[:ordem_servico][:cliente_id])
      @solucoes = Solucao.to_select_by_cliente(params[:ordem_servico][:cliente_id])

    else
      @cliente_contatos = []
      @solucoes = []
    end    
  end

  def permite_editar_excluir
    return if @ordem_servico.cadastrante.id == current_usuario.id
    redirect_to usuario_ordem_servicos_path
    flash[:warning] = "Edição/Exclusão permitida apenas para o usuário
                      que cadastrou (#{@ordem_servico.cadastrante.nome})."
  end

end
