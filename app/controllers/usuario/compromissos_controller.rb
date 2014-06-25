# -*- encoding : utf-8 -*-
class Usuario::CompromissosController < Usuario::BaseController
  before_filter :carrega_compromisso, :except => [:index,:new,:create]
  before_filter :carregar_dados, :except => [:show, :destroy]

  def index
    @compromissos = Compromisso.includes(:usuario).where("id > 0")
    @compromissos = @compromissos.where(usuario_id:params[:usuario_id]) if params[:usuario_id].present?
    @usuario_id = params[:usuario_id] ? params[:usuario_id] : ""

    @compromissos_por_data = @compromissos.group_by(&:data_inicio)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_with(@compromissos)
  end

  def show
    respond_with(@compromisso)
  end

  def new
    @compromisso = Compromisso.new
    respond_with(@compromisso)
  end

  def edit;  end

  def create
    @compromisso = Compromisso.new(params[:compromisso])
    @compromisso.usuario_cadastrante_id = current_usuario.id
    @compromisso.save
    respond_with(@compromisso)
  end

  def update
    @compromisso.update_attributes(params[:compromisso])
    respond_with(@compromisso)
  end

  def destroy
    @compromisso.destroy
    respond_with(@compromisso)
  end

private
  
  def carrega_compromisso
    @compromisso = Compromisso.find(params[:id])    
  end

  def carregar_dados
    @usuarios = Usuario.to_select
  end
end
