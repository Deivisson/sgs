# -*- encoding : utf-8 -*-
class Usuario::ClientesController < Usuario::CadastrosBasicosController
  before_filter :filtro_cliente,    :only =>  [:index]
  before_filter :carrega_cliente,   :except => [:index,:new, :create]
  before_filter :carrega_solucoes,  :except => [:index]
  before_filter :carrega_dados,     :except => [:index,:destroy,:show]  

  def index
    @clientes = Cliente.where("id > 0")
    if @conteudo_busca_cliente.present?
      @clientes = @clientes.where("(nome like :a or apelido like :a or cnpj like :a)",a:"%#{@conteudo_busca_cliente}%")
    end
    @clientes = @clientes.order(:nome).paginate :page => params['page'], :per_page =>25
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
    @conteudo_busca_cliente = ""
    if params[:conteudo_busca_cliente].nil?
      @conteudo_busca_cliente = session[:conteudo_busca_cliente] || ""
    elsif params[:conteudo_busca_cliente].present?
      @conteudo_busca_cliente = params[:conteudo_busca_cliente]
    end  
    session[:conteudo_busca_cliente] = @conteudo_busca_cliente
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
