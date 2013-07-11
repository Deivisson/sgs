# -*- encoding : utf-8 -*-
class Usuario::AtendimentosController < Usuario::BaseController

  before_filter :carrega_dados, :only => [:new,:edit]

  def index
    @atendimentos = Atendimento.lista_atendimentos
  end

  def show
    @atendimento = Atendimento.find(params[:id])
    @solicitacoes = Solicitacao.solicitacoes_por_atendimento(params[:id])
  end

  def new
    attributes = {
      :usuario_solicitante => current_usuario,
      :usuario_cadastrante => current_usuario,:interno => false
    }
    @atendimento = Atendimento.new(attributes)
  end

  def create
    @atendimento = Atendimento.new(params[:atendimento])
    if @atendimento.save
      redirect_to new_usuario_solicitacao_path(:atendimento => @atendimento)
    else
      render :action => 'new'
    end
  end

  def edit
    @atendimento = Atendimento.find(params[:id])
    @desabilita_cliente = true if @atendimento.solicitacoes.count > 0
    @hint = 'Cliente não poderá ser alterado, devido vínculos com solicitações.' if @desabilita_cliente
  end

  def update
    @atendimento = Atendimento.find(params[:id])
    if @atendimento.update_attributes(params[:atendimento])
      flash[:notice] = "Atendimento atualizado com sucesso."
      redirect_to [:usuario, @atendimento]
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @atendimento = Atendimento.find(params[:id])
      @atendimento.delete
      flash[:notice] = "Atendimento excluído com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este atendimento."
    ensure
      redirect_to usuario_atendimentos_url
    end
  end

  def carrega_dados
    @clientes = Cliente.to_select
    @usuarios = Usuario.to_select
  end
end
