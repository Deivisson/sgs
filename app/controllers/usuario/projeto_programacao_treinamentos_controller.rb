class Usuario::ProjetoProgramacaoTreinamentosController < Usuario::BaseController
  before_filter :carrega_programacao_treinamento, :except => [:index,:new,:create] 
  before_filter :carrega_dados, :except => [:index,:show,:destroy]

  def index
    @projeto = Projeto.find(params[:projeto_id])
    if params[:sub_modulo_id].present?
      @solucao_sub_modulo = SolucaoSubModulo.find(params[:sub_modulo_id])
      carrega_projeto_programacao_treinamentos(params[:projeto_id],@solucao_sub_modulo.id)
    else
      @solucao_sub_modulo = nil
      carrega_projeto_programacao_treinamentos(params[:projeto_id])
    end
    respond_with(@projeto_programacao_treinamentos)
  end

  def show
    respond_with(@projeto_programacao_treinamento)
  end

  def new
    args = {
        projeto_id:params[:projeto_id],
        solucao_sub_modulo_ids:params[:sub_modulo_ids].split(",")
    }
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
    @projeto = @projeto_programacao_treinamento.projeto
    @projeto_programacao_treinamento.destroy
    respond_with(@projeto_programacao_treinamento)
  end
  
  def remove_sub_modulo
    @solucao_sub_modulo = @projeto_programacao_treinamento.solucao_sub_modulos.find(params[:solucao_sub_modulo_id])
    if @solucao_sub_modulo
      @projeto_programacao_treinamento.solucao_sub_modulos.delete(@solucao_sub_modulo)
      carrega_projeto_programacao_treinamentos(@projeto_programacao_treinamento.projeto_id,
                                               params[:solucao_sub_modulo_id])
    end
  end

private

  def carrega_programacao_treinamento
    @projeto_programacao_treinamento = ProjetoProgramacaoTreinamento.find(params[:id])
  end

  def carrega_dados
    @usuarios = Usuario.to_select
  end

  def carrega_projeto_programacao_treinamentos(projeto_id,sub_modulo_id=nil)
    if sub_modulo_id.nil?
      @projeto_programacao_treinamentos =  ProjetoProgramacaoTreinamento.where(
        "projeto_id = ?",projeto_id)
    else
      @projeto_programacao_treinamentos =  ProjetoProgramacaoTreinamento.joins(:solucao_sub_modulos)
      @projeto_programacao_treinamentos = @projeto_programacao_treinamentos.where(
        "projeto_id = ? and projeto_programacao_treinamentos_solucao_sub_modulos.solucao_sub_modulo_id = ?",
        projeto_id,sub_modulo_id
      )
    end
  end
end
