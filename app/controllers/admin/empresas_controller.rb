# -*- encoding : utf-8 -*-
class Admin::EmpresasController < Admin::BaseController
  def show
    @empresa = Empresa.find(params[:id])
  end

  def edit
    @empresa = Empresa.find(params[:id])
  end

  def update
    @empresa = Empresa.find(params[:id])
    if @empresa.update_attributes(params[:empresa])
      flash[:notice] = "Empresa atualizada com sucesso."
      redirect_to [:admin,@empresa]
    else
      render :action => 'edit'
    end
  end
end
