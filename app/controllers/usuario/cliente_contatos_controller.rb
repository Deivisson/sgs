# -*- encoding : utf-8 -*-
class Usuario::ClienteContatosController < Usuario::CadastrosBasicosController
  before_filter except:[:update,:create] do |c| 
    c.instance_eval { c.permissao_usuario!(("#{action_name}_contato_cliente").to_sym)}
  end
  before_filter :carrega_cliente_contato, :except => [:index,:new, :create]

  def index
    @cliente_contatos = ClienteContato.lista_contatos
  end

  def show
    @local = params[:local] if params[:local]
  end

  def new
    @cliente_contato = ClienteContato.new()
    @cliente_contato.cliente_id = params[:cliente] if params[:cliente]
    @clientes = Cliente.to_select
    @local = params[:local] if params[:local]
  end

  def create
    @cliente_contato = ClienteContato.new(params[:cliente_contato])
    if @cliente_contato.save
      flash[:notice] = "Contato cadastrado com sucesso."
        redirect_to [:usuario, @cliente_contato.cliente]
    else
      render :action => 'new'
    end
  end

  def edit
    @local = params[:local] if params[:local]
  end

  def update
    if @cliente_contato.update_attributes(params[:cliente_contato])
      flash[:notice] = "Contato atualizado com sucesso."
      redirect_to [:usuario, @cliente_contato.cliente]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @cliente_contato.delete
      flash[:notice] = "Contato excluido com sucesso."
    rescue
      flash[:warning] = "Exclusao nao permitida para este contato."
    ensure
      redirect_to [:usuario, @cliente_contato.cliente]
    end
   end


 private

  def carrega_cliente_contato
    @cliente_contato = ClienteContato.find(params[:id])
  end
end
