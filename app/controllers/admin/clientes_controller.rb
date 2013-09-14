# -*- encoding : utf-8 -*-
class Admin::ClientesController < Admin::BaseController
  before_filter :carrega_solucoes,  :only => [:new,:edit,:create,:update]
  before_filter :carrega_cliente,   :except => [:index,:new, :create]

  def index
    @clientes = Cliente.order(:nome).paginate :page => params['page'], :per_page =>25
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
      redirect_to [:admin,@cliente]
    else
      render :action => 'new'
    end
  end

  def edit; end

  def update
    if @cliente.update_attributes(params[:cliente])
      flash[:notice] = "Cliente atualizado com sucesso."
      redirect_to [:admin,@cliente]
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
      redirect_to admin_clientes_url
    end
  end

private

  def carrega_cliente
    @cliente = Cliente.find(params[:id])
  end

  def carrega_solucoes
    @solucoes = Solucao.joins(:solucao_modulos => :solucao_sub_modulos)
    @solucoes = @solucoes.order("solucoes.descricao,solucao_modulos.descricao,
                                solucao_sub_modulos.descricao")
    @solucoes = @solucoes.select("solucoes.id as solucao_id, solucoes.descricao as solucao_descricao,
                                  solucao_modulos.id as modulo_id, solucao_modulos.descricao as modulo_descricao,
                                  solucao_sub_modulos.id as sub_modulo_id, solucao_sub_modulos.descricao as sub_modulo_descricao")
  end

end
