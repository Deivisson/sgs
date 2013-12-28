# -*- encoding : utf-8 -*-
class Usuario::SolicitacoesController < Usuario::BaseController
  before_filter :set_current_menu
  before_filter :carrega_solicitacao, :only => [:show, :edit, :update, :destroy,:programar]
  before_filter :carrega_dados, :only => [:new,:edit,:index]
  after_filter :carrega_contatos_e_projetos_cliente, :only => [:new,:edit]
  before_filter :atualizacao_multipla_permitida, :only => :update_multiple

  #Carrega Solicitacoes para usuario logado no sistema.
  #Condicoes de filtro
  #   @params[:status_id]             => Id do Status a ser exibido
  #   @params[:status_description]    => Descricao do Status
  #PS.: Se parametro "status_id" informado, carregara apenas registros para aquele status,
  #senao, ira recupera os registros para o primeiro status, quando houver.
  def index
    @status_description = "Sem Solicitações"
    @solicitacoes = []
    @solucao_id = params[:solucao_id] if params[:solucao_id]
    if params[:conditions]    
      @status_id = params[:conditions]["status_id"] 
      @status = Status.find(@status_id)
    else
      if params[:status_id]
        @status_id = params[:status_id] 
        @status_description = Status.find(params[:status_id]).descricao if params[:status_id]
      else  
        @status = Status.primeira_ocorrencia_por_status(current_usuario.id)
        @status_id = @status.id if @status
        @status_description = @status.descricao if @status
      end

    end
    if @status != nil or params[:status_id]
      @solicitacoes = Solicitacao.search(params[:conditions]).tarefas_do_usuario_por_status(
                      monta_filtro,params['page'],9990) 
    end
    respond_with @solicitacoes
  end

  def search
    @search_key = params[:search_key]
    if @search_key.to_i == 0
      @solicitacoes = Solicitacao.where("titulo like :a OR detalhe like :a",:a => "%#{@search_key}%")
    else
      @solicitacoes = Solicitacao.where("id = ? ", @search_key)
    end  
    @solicitacoes = @solicitacoes.order("id desc")
  end

  def show
    @local = params[:local] if params[:local]
    if @solicitacao.nao_lido and @solicitacao.usuario_responsavel_id == current_usuario.id
      @solicitacao.update_attributes!(:nao_lido => false) 
    end
    @solicitacao_historicos = SolicitacaoHistorico.where(solicitacao_id:@solicitacao.id)
    @solicitacao_historicos = @solicitacao_historicos.order("created_at DESC")
    render :layout  => "projeto"
  end

  def new
    @solicitacao = Solicitacao.new(:status_id => Status::ABERTO)
    if params[:projeto_id]
      projeto = Projeto.find(params[:projeto_id])
      @solicitacao.cliente_id = projeto.cliente_id
      @solicitacao.projeto_id = projeto.id
      @solicitacao.etapa_id = params[:etapa_id]
    end
    carrega_contatos_e_projetos_cliente
    @local = params[:local] if params[:local]
    @status_id = params[:status_id] if params[:status_id]
    @usuarios = Usuario.to_select_by_status(Status::ABERTO)
  end

  def create
    params[:solicitacao].merge!(:usuario_cadastrante_id => current_usuario.id)
    @solicitacao = Solicitacao.new(params[:solicitacao])
    if @solicitacao.save
      flash[:notice] = "Solicitação cadastrada com sucesso."
    else
      carrega_dados
    end
  end

  def edit
    @contatos = ClienteContato.to_select_by_cliente @solicitacao.cliente_id
    @solucoes = Solucao.to_select_by_cliente @solicitacao.cliente_id
    @sub_modulos = SolucaoSubModulo.to_select_by_modulo @solicitacao.modulo_id

    @local = params[:local] if params[:local] and permite_alterar_excluir
    redirect_to :controller => 'solicitacoes', 
                :action => 'index',
                :status_id => @solicitacao.status_id if not permite_alterar_excluir
  end

  def programar
    
  end

  def update
    if @solicitacao.update_attributes(params[:solicitacao])
      flash[:notice] = "Solicitação atualizada com sucesso."
    end
  end

  def destroy
    if permite_alterar_excluir(2)
      @solicitacao.destroy
      #Existem validacoes no callback "before_destroy" que podem cancelar a operacao
      if @solicitacao.errors.count > 0 
        flash[:warning] = @solicitacao.errors.on_base
      else
        flash[:notice] = "Solicitação excluída com sucesso."
      end
    end
    redirect_to usuario_solicitacoes_path
  end

  #Valida quem esta tentando editar ou excluir uma solicitacao.
  #Operacao permitida apenas para usuario que cadastrou
  def permite_alterar_excluir(tipo = 1)
    if @solicitacao.usuario_cadastrante.id == current_usuario.id
      return true
    else
      flash[:warning] = "#{tipo == 1 ? 'Edição' : 'Exclusão'} 
                          Edição permitida apenas para o usuário que cadastrou."
      return false
    end
  end

  #Permite a edicao de varios registros ao mesmo tempo, desde que
  #os mesmos tenham sido selecionado atraves do check-box na coluna
  #de cada registro. Esta opção é utilizada para a mudanca de status
  #das solicitacoes.
  def edit_multiple
    @status_id = params[:status_id]
    if params[:solicitacao_ids]
      @solicitacoes = Solicitacao.find(params[:solicitacao_ids])
    else
      flash[:warning] = 'É necessário selecionar as solicitações.'
      redirect_to :controller => 'solicitacoes',
                  :action => 'index',
                  :status_id => @status_id
    end
  end

  #Atualiza Todos os registros selecionado. Utilizado para atualizar
  #os status dos mesmos
  def update_multiple
    @solicitacoes.each do |solicitacao|
      if solicitacao.update_attributes!(params[:solicitacao].reject { |k,v| v.blank?})
        SolicitacaoHistorico.create(
          :usuario_id             => current_usuario.id,
          :detalhe                => solicitacao.detalhe_ultimo_historico,
          :solicitacao_id         => solicitacao.id,
          :status_id              => solicitacao.status_id,
          :usuario_responsavel_id => solicitacao.usuario_responsavel_id)
      else
        render :action => 'edit_multiple'
        @has_error = true
      end
    end
    if not @has_error
      flash[:notice]  = "Solicitações processadas com sucesso."
      redirect_to :controller => 'solicitacoes',
                  :action     => 'index', 
                  :status_id  => params[:status_id]
    end
  end

  def enviar_email_confirmacao_leitura
    #Recupera o usuário que solicitou a confirmacao de leitura apartir do ultimo histórico
    #begin
      msg_body = "Solicitação nº #{@solicitacao.id.to_s.rjust(6,'0')} 
                 foi visualizada pelo usuário #{current_usuario.nome} às #{Time.now.to_s_br}<p>
                 #{current_usuario.usuario_config.assinatura_email}</p>"

      historico = SolicitacaoHistorico.last(:conditions => {:solicitacao_id => @solicitacao.id} )
      Mailer.deliver_padrao(msg_body,"Solicitação Lida",historico.usuario.email,current_usuario.email)
      @solicitacao.update_attributes(:confirmacao_leitura => false)
    #rescue
    #end
  end

private 
  
  #Carrega dados para Combos Fixos
  def carrega_dados
    @clientes = Cliente.to_select_by_usuario(current_usuario.id).order(:nome)
    flash[:notice] = "#{current_usuario.nome}, entre nas suas configurações e 
                      informe quais Solucoes você irá trabalhar, para que os
                      clientes sejam carregados." if @clientes.empty?
    @prioridades = Prioridade.to_select
    @tipo_pendencias = TipoPendencia.to_select
    carrega_contatos_e_projetos_cliente
  end

  def carrega_contatos_e_projetos_cliente
    return if @solicitacao.nil?
    unless @solicitacao.associador.nil?
      id = @solicitacao.associador.cliente_id
      @contatos = ClienteContato.where(cliente_id:id) 
      @solucoes = Solucao.joins(:clientes).where("clientes.id = ?",id)
    end
  end

  def carrega_solicitacao
    @solicitacao = Solicitacao.find(params[:id])
  end

  def atualizacao_multipla_permitida
    c1 = %w(status_id usuario_responsavel_id)

    #Campo que serão validados apenas quando movendo Status para 
    #aguardando desenvolvimento ou em desenvolvimento
    c2 = %w(gera_cobranca previsao_duracao_horas 
            nivel_complexidade valor_cobranca) 

    campos = %w(status_id usuario_responsavel_id gera_cobranca 
            previsao_duracao_horas nivel_complexidade valor_cobranca)

    @solicitacoes = Solicitacao.find(params[:solicitacao_ids])
    @solicitacao = Solicitacao.new(params[:solicitacao])
    @solicitacao.valid?
    for campo in campos do
      if @solicitacao.errors[campo.to_sym].present? 
        if ((c2.include? campo) && 
            ([Status::AG_DESENV, Status::EM_DESENV].include?  @solicitacao.status_id) && 
            @solicitacoes[0].pendente_previsao?) || (c1.include? campo)
          
          puts "CAMPO É ---> #{campo}"
          render :action => 'edit_multiple' 
          break
        end
      end
    end
    
  end

  def monta_filtro
    if @solucao_id
      ["usuario_responsavel_id = ? AND status_id = ? AND solucao_id = ?", 
      current_usuario.id,@status_id, @solucao_id]
    else
      {:usuario_responsavel_id => current_usuario.id,
       :status_id => @status_id}
    end
  end

  def set_current_menu
    session[:current_menu] = "solicitacao"
  end
end
