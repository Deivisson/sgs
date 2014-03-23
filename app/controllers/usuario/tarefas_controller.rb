# -*- encoding : utf-8 -*-
class Usuario::TarefasController < Usuario::BaseController
	layout "tarefas"
  before_filter :carrega_dados, :only => [:index,:create,:update]

  def index
	 	@solicitacoes = Solicitacao.order("id,prioridade_id").limit(16)
  end

  def new
  	attributes = {
  		solicitacao_id:params[:solicitacao_id],
  		usuario_id:params[:usuario_id]
  	}
		@tarefa = Tarefa.new(attributes)
  end

  def create
  	@tarefa = Tarefa.new(params[:tarefa])
  	@tarefa.save
  	respond_with(@tarefa)
  end

private 
  
  def carrega_dados
    @d_ini = Date.today
    @d_fim = Date.today + 20.days
    unless Tarefa.first.nil?
      @d_ini = Tarefa.minimum(:data_hora_inicio).to_date
      @d_fim = (Tarefa.maximum(:data_hora_fim) + 20.days).to_date
    end
    @usuarios = Usuario.limit(3)  
  end
end