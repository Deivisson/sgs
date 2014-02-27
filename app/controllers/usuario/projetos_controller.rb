class Usuario::ProjetosController < Usuario::BaseController
  before_filter :set_current_menu
  before_filter :carrega_projeto, :except => [:index,:new, :create]
  before_filter :load_clientes, except:[:show,:destroy]
  before_filter :load_usuarios, only:[:index]
  before_filter :load_dados, except:[:show,:index,:destroy]
  before_filter :get_etapas_ids, :only => [:update,:create]

  def index
    @projetos = Projeto.includes(:cliente, :usuario)
    @projetos = @projetos.search(params[:conditions])
    #render :layout  => "lista_projetos"
  end

  def show
    @projeto = Projeto.find(params[:id])
    render :layout  => "projeto"
  end

  def new
    @projeto = Projeto.new
  end

  def edit;  end

  def create
    params[:projeto].merge!({usuario_id:current_usuario.id,status:Projeto::ATIVO})
    @projeto = Projeto.new(params[:projeto])
    @projeto.ordem = @etapas_ordem
    if @projeto.save
      flash[:notice]= "Abertura de Projeto realizada com sucesso."
    end
    respond_with(@projeto)
  end

  def update
    @projeto.ordem = @etapas_ordem
    if @projeto.update_attributes(params[:projeto])
      flash[:notice]= "Atualizacao de Projeto realizada com sucesso."
    end    
    respond_with(@projeto)
  end

  def destroy
    @projeto.destroy
    respond_with(@projeto)
  end


private
  
  def carrega_projeto
    @projeto = Projeto.find(params[:id])
  end
  def get_etapas_ids
    @etapas_ordem = params[:projeto][:etapa_ids] || []
  end

  def load_clientes
    @clientes = Cliente.to_select
  end

  def load_usuarios
    @usuarios = Usuario.to_select
  end

  def load_dados
    @etapas = Etapa.all
    if @projeto.nil? || @projeto.cliente.nil?
      @solucoes = Solucao.all
    else
      @solucoes = @projeto.cliente.solucoes
    end
  end

  def set_current_menu
    session[:current_menu] = "projeto"
  end
end
