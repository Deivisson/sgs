# -*- encoding : utf-8 -*-
class Usuario::CategoriaClientesController < Usuario::CadastrosBasicosController
  before_filter { |c| c.permissao_usuario!(("#{action_name}_categoria_cliente").to_sym) }
  before_filter :set_categoria_cliente, only: [:show, :edit, :update, :destroy]

  def index
    @categoria_clientes = CategoriaCliente.order(:descricao)
    respond_with(@categoria_clientes)
  end

  def show
    respond_with(@categoria_cliente)
  end

  def new
    @categoria_cliente = CategoriaCliente.new
    respond_with(@categoria_cliente)
  end

  def edit
  end

  def create
    @categoria_cliente = CategoriaCliente.new(params[:categoria_cliente])
    @categoria_cliente.save
    respond_with(@categoria_cliente, location: usuario_categoria_clientes_path)
  end

  def update
    @categoria_cliente.update_attributes(params[:categoria_cliente])
    respond_with(@categoria_cliente, location: usuario_categoria_cliente_path(@categoria_cliente))
  end

  def destroy
    @categoria_cliente.destroy
    respond_with(@categoria_cliente, location: usuario_categoria_clientes_path)
  end

  private
    def set_categoria_cliente
      @categoria_cliente = CategoriaCliente.find(params[:id])
    end

end
