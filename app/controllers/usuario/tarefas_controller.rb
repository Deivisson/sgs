# -*- encoding : utf-8 -*-
class Usuario::TarefasController < Usuario::BaseController
	layout "tarefas"
  #before_filter :carrega_dados, :only => [:new,:edit]

  def index
	 	@solicitacoes = Solicitacao.limit(6)
 		@usuarios = Usuario.limit(3)
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
end