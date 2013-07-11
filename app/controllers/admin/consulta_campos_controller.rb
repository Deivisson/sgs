# -*- encoding : utf-8 -*-
class Admin::ConsultaCamposController < Admin::BaseController

  def index
    @consulta = Consulta.find(params[:consulta])
    @consulta_campos = ConsultaCampo.find(:all,
                    :conditions => {:consulta_id => @consulta.id},
                    :order => :ordem )
  end

  def new
    @consulta_campo = ConsultaCampo.new(:consulta_id => params[:consulta])
  end

  def create
    @consulta_campo = ConsultaCampo.new(params[:consulta_campo])
    if @consulta_campo.save
      flash[:notice] = "Campo Cadastrado com sucesso."
      redirect_to consulta_campos_path(:consulta => @consulta_campo.consulta_id)
    else
      render :action => 'new'
    end
  end

  def edit
     @consulta_campo = ConsultaCampo.find(params[:id])
     if not can_edit_destroy
        redirect_to consulta_campos_path(:consulta => @consulta_campo.consulta_id)
     end
  end

  def update
    @consulta_campo = ConsultaCampo.find(params[:id])
    if @consulta_campo.update_attributes(params[:consulta_campo])
      flash[:notice] = "Campo atualizado com sucesso."
      redirect_to consulta_campos_path(:consulta => @consulta_campo.consulta_id)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @consulta_campo = ConsultaCampo.find(params[:id])
    if can_edit_destroy
      @consulta_campo.destroy
      flash[:notice] = "Campo excluído com sucesso."
    end
    redirect_to consulta_campos_path(:consulta => @consulta_campo.consulta_id)
  end

  def can_edit_destroy
    if @consulta_campo.padrao
      flash[:warning] = "Edição e/ou Exclusão não permitida para campos padrão do sistema."
      return false
    else
      return true
    end
  end

  def sort
    params[:campos].each_with_index do |id, index|
      ConsultaCampo.update_all(['ordem=?',index+1],['id=?',id])
    end
    render :nothing => true
  end

  def update_individual
     ConsultaCampo.update(params[:consulta_campos].keys,params[:consulta_campos].values)
     flash[:notice] = "Campos Atualizados com Sucesso."
     redirect_to consultas_path
  end
end
