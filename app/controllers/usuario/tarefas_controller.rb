# -*- encoding : utf-8 -*-
class Usuario::TarefasController < Usuario::BaseController
	layout "tarefas"
  before_filter :carrega_tarefa, :only => [:show, :edit,:update, :destroy]
  before_filter :carrega_dados, :only => [:index,:create,:update]

  def index
    @from_index = false
    if params[:solicitacao_ids].present?
      ids = params[:solicitacao_ids].split(",")
  	 	@solicitacoes = Solicitacao.joins("LEFT JOIN tarefas on tarefas.solicitacao_id = solicitacoes.id INNER JOIN status on status.id = solicitacoes.status_id")
      @solicitacoes = @solicitacoes.where("solicitacoes.id in (?) and tarefas.id IS NULL ",ids)
      @solicitacoes = @solicitacoes.where("status.encerramento = ?",false)
      @solicitacoes = @solicitacoes.order("prioridade_id")
    elsif params[:from].present?
      @from_index = true
    else
      flash[:warning] = "É necessário selecionar as solicitacoes."
      redirect_to usuario_solicitacoes_path
    end
  end

  def new
  	attributes = {
  		solicitacao_id:params[:solicitacao_id],
  		usuario_id:params[:usuario_id]
  	}
		@tarefa = Tarefa.new(attributes)
  end

  def edit; end

  def update
    @tarefa.update_attributes(params[:tarefa])
    respond_with(@tarefa)
  end

  def create
  	@tarefa = Tarefa.new(params[:tarefa])
  	@tarefa.save
  	respond_with(@tarefa)
  end

  def show;  end

  def destroy
    @tarefa.destroy
    respond_with(@tarefa)
  end
private 
  
  def carrega_tarefa
    @tarefa = Tarefa.find(params[:id])  
  end

  def carrega_dados
    @d_ini = Date.today
    @d_fim = Date.today + 20.days
    unless Tarefa.first.nil?
      @d_ini = Tarefa.minimum(:data_hora_inicio).to_date
      @d_fim = (Tarefa.maximum(:data_hora_fim) + 20.days).to_date
    end
    @usuarios = Usuario.to_select_by_status(Status::AG_DESENV) 
  end
end