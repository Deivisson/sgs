class Usuario::ProjetoProgramacaoTreinamentosController < Usuario::BaseController
  before_filter :carrega_programacao_treinamento, :only => [:edit, :update, :show,:delete]
  before_filter :carrega_dados, :except => [:index,:show,:destroy]

  def show
    respond_with(@projeto_programacao_treinamento)
  end

  def new
    args = {
        projeto_id:params[:projeto_id],
        solucao_sub_modulo_ids:params[:sub_modulo_ids].split(",")
    }
    puts args
    @projeto_programacao_treinamento = ProjetoProgramacaoTreinamento.new(args)
    respond_with(@projeto_programacao_treinamento)
  end

  def edit; end

  def create
    @projeto_programacao_treinamento = ProjetoProgramacaoTreinamento.new(params[:projeto_programacao_treinamento])
    @projeto_programacao_treinamento.save
    respond_with(@projeto_programacao_treinamento)
  end

  def update
    @projeto_programacao_treinamento.update_attributes(params[:projeto_programacao_treinamento])
    respond_with(@projeto_programacao_treinamento)
  end

  def destroy
    @projeto_programacao_treinamento.destroy
    respond_with(@projeto_programacao_treinamento)
  end
  
private
  def carrega_programacao_treinamento
    @projeto_programacao_treinamento = ProjetoProgramacaoTreinamento.find(params[:id])
  end

  def carrega_dados
    @usuarios = Usuario.to_select
  end
end
