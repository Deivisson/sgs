# -*- encoding : utf-8 -*-
class Admin::TipoPendenciasController <  Admin::BaseController
  def index
    @tipo_pendencias = TipoPendencia.all(:order => "id desc")
  end

  def show
    @tipo_pendencia = TipoPendencia.find(params[:id])
  end

  def new
    @tipo_pendencia = TipoPendencia.new
  end

  def create
    @tipo_pendencia = TipoPendencia.new(params[:tipo_pendencia])
    if @tipo_pendencia.save
      flash[:notice] = "Tipo Pendência cadastrada com sucesso."
      redirect_to admin_tipo_pendencias_path
    else
      render :action => 'new'
    end
  end

  def edit
    @tipo_pendencia = TipoPendencia.find(params[:id])
  end

  def update
    @tipo_pendencia = TipoPendencia.find(params[:id])
    if @tipo_pendencia.update_attributes(params[:tipo_pendencia])
      flash[:notice] = "Tipo pendência atualizada com sucesso."
      redirect_to admin_tipo_pendencias_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @tipo_pendencia = TipoPendencia.find(params[:id])
      @tipo_pendencia.delete
      flash[:notice] = "Tipo pendência excluída com sucesso."
    rescue
      flash[:warning] = "Exclusão não permitida para este tipo de pendência."
    ensure
      redirect_to admin_tipo_pendencias_url
    end
  end
end
