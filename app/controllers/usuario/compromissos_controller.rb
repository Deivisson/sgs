# -*- encoding : utf-8 -*-
class Usuario::CompromissosController < Usuario::BaseController

  before_filter :set_current_menu
  before_filter :carrega_compromisso, :except => [:index,:new,:create]
  before_filter :carregar_dados, :except => [:show, :destroy]

  def index
    @usuario = params[:usuario_id].present? ? Usuario.find(params[:usuario_id]) : nil
    @compromissos = Compromisso.includes(:usuario).where("compromissos.id > 0")
    if params[:projeto_id].present?
      @compromissos = @compromissos.joins(:treinamento)
      @compromissos = @compromissos.where("projeto_programacao_treinamentos.projeto_id = ? ",params[:projeto_id])
    end
    @compromissos = @compromissos.where(usuario_id:@usuario.id) unless @usuario.nil?

    @compromissos_por_data = @compromissos.group_by(&:data_inicio)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_with(@compromissos, layout: params[:prog_treinamento].present? ? "compromisso_modal"  : "application")
  end

  def show
    respond_with(@compromisso)
  end

  def new
    attributes = {usuario_id:current_usuario.id}
    attributes.merge!(:data_inicio => params[:date]) if params[:date].present?
    @compromisso = Compromisso.new(attributes)
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

  def set_current_menu
    session[:current_menu] = "agenda"
  end  
end
