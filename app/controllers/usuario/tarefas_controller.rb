# -*- encoding : utf-8 -*-
class Usuario::TarefasController < Usuario::BaseController
	layout "tarefas"
  #before_filter :carrega_dados, :only => [:new,:edit]

  def index
 		 @solicitacoes = Solicitacao.limit(5)
 		 @usuarios = Usuario.limit(3)
  end

end