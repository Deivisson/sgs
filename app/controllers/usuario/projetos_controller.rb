class Usuario::ProjetosController < Usuario::BaseController
  before_filter :load_clientes, except:[:show,:destroy]
  before_filter :load_usuarios, only:[:index]
  before_filter :load_dados, except:[:show,:index,:destroy]

  def index
    @projetos = Projeto.includes(:cliente, :usuario)
    @projetos = @projetos.search(params[:conditions])
    render :layout  => "lista_projetos"
  end

  def show
    @projeto = Projeto.find(params[:id])
    render :layout  => "projeto"
  end

  def new
    @projeto = Projeto.new
  end

  def edit
    @projeto = Projeto.find(params[:id])
  end

  def create
    params[:projeto].merge!({usuario_id:current_usuario.id,status:Projeto::ATIVO})
    @projeto = Projeto.new(params[:projeto])
    if @projeto.save
      flash[:notice]= "Abertura de Projeto realizada com sucesso."
    end
    respond_with(@projeto)
  end

  def update
    @projeto = Projeto.find(params[:id])
    if @projeto.update_attributes(params[:projeto])
      flash[:notice]= "Atualizacao de Projeto realizada com sucesso."
    end    
    respond_with(@projeto)
  end

  def destroy
    @projeto = Projeto.find(params[:id])
    @projeto.destroy
    respond_with(@projeto)
  end


private

  def load_clientes
    @clientes = Cliente.to_select
  end

  def load_usuarios
    @usuarios = Usuario.to_select
  end

  def load_dados
    @etapas = Etapa.all
  end
end
