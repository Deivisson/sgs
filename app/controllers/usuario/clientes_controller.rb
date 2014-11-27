# -*- encoding : utf-8 -*-
class Usuario::ClientesController < Usuario::CadastrosBasicosController
  before_filter except:[:update,:create] do |c| 
    c.instance_eval { c.permissao_usuario!(("#{action_name}_cliente").to_sym)}
  end

  before_filter :filtro_cliente,    :only =>  [:index]
  before_filter :carrega_cliente,   :except => [:index,:new, :create]
  before_filter :carrega_solucoes,  :except => [:index]
  before_filter :carrega_dados,     :except => [:index,:destroy,:show]  

  def index
    @clientes = Cliente.where("id > 0").includes(:categoria)
    if @conteudo_busca_cliente.present?
      @clientes = @clientes.where("(nome like :a or apelido like :a or cnpj like :a)",a:"%#{@conteudo_busca_cliente}%")
    end
    if @categoria_cliente.to_i > 0
      @clientes = @clientes.where("categoria_cliente_id = ? ", @categoria_cliente)
    end
    @clientes = @clientes.order(:nome).paginate :page => @page, :per_page =>25
    @categoria_clientes = CategoriaCliente.order(:descricao)
    respond_with(@clientes)
  end

  def show
    @cliente_contatos = ClienteContato.find_all_by_cliente_id(params[:id])
  end

  def new
    @cliente = Cliente.new
  end

  def create
    @cliente = Cliente.new(params[:cliente])
    if @cliente.save
      flash[:notice] = "Cliente cadastrado com sucesso."
      redirect_to [:usuario,@cliente]
    else
      render :action => 'new'
    end
  end

  def edit; end

  def update
    if @cliente.update_attributes(params[:cliente])
      flash[:notice] = "Cliente atualizado com sucesso."
      redirect_to [:usuario,@cliente]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @cliente.delete
      flash[:notice] = "Cliente excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este cliente."
    ensure
      redirect_to usuario_clientes_url
    end
  end

private

  def filtro_cliente
    @page = nil
    if params[:page].nil?
      @page = session[:page_cliente] || nil
    elsif params[:page].present?
      @page = params[:page]
    end

    @conteudo_busca_cliente = ""
    if params[:conteudo_busca_cliente].nil?
      @conteudo_busca_cliente = session[:conteudo_busca_cliente] || ""
    elsif params[:conteudo_busca_cliente].present?
      @conteudo_busca_cliente = params[:conteudo_busca_cliente]
      params.delete(:conteudo_busca_cliente)
      @page = nil
    end

    @categoria_cliente = 0
    if params[:categoria_cliente].nil?
      @categoria_cliente = session[:categoria_cliente] || ""
    elsif params[:categoria_cliente].present?
      @categoria_cliente = params[:categoria_cliente]
      params.delete(:categoria_cliente)
      @page = nil
    end    
    session[:conteudo_busca_cliente] = @conteudo_busca_cliente
    session[:categoria_cliente] = @categoria_cliente
    session[:page_cliente] = @page
  end

  def carrega_cliente
    @cliente = Cliente.find(params[:id])
  end

  def carrega_solucoes
    if action_name == "show"
      @solucoes = @cliente.solucoes.order(:ordem)
    else
      @solucoes = Solucao.order(:ordem)
    end
  end

  def carrega_dados
    @categoria_clientes = CategoriaCliente.order(:descricao)
  end

end
