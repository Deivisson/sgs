class Usuario::CompromissosController < Usuario::BaseController
  
  def index
    @compromissos = Compromisso.all
    @compromissos_por_data = @compromissos.group_by(&:data_inicio)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_with(@compromissos)
  end

  def show
    @compromisso = Compromisso.find(params[:id])
    respond_with(@compromisso)
  end

  def new
    @compromisso = Compromisso.new
    respond_with(@compromisso)
  end

  def edit
    @compromisso = Compromisso.find(params[:id])
  end

  def create
    @compromisso = Compromisso.new(params[:compromisso])
    @compromisso.save
    respond_with(@compromisso)
  end

  def update
    @compromisso = Compromisso.find(params[:id])
    @compromisso.update_attributes(params[:compromisso])
    respond_with(@compromisso)
  end

  def destroy
    @compromisso = Compromisso.find(params[:id])
    @compromisso.destroy
    respond_with(@compromisso)
  end
end
