# -*- encoding : utf-8 -*-
class Admin::StatusController <  Admin::BaseController
  def index
    @status = Status.all
  end

  def show
    @status = Status.find(params[:id])
    @tempo_evolucoes = @status.tempo_evolucoes.order(:tipo_pendencia_id)
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params[:status])
    if @status.save
      flash[:notice] = "Status cadastrado com sucesso."
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @status = Status.find(params[:id])
    redirect_to :controller => 'status',:action => 'index' if not permite_edicao_exclusao
  end

  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      flash[:notice] = "Status atualizado com sucesso."
      redirect_to @status
    else
      render :action => 'edit'
    end
  end

  def destroy
    @status = Status.find(params[:id])
    if permite_edicao_exclusao
      begin
        @status.delete
        flash[:notice] = "Status excluída com sucesso."
      rescue
        flash[:warning] = "Status não poderá ser exlcuído."
      end
    end
    redirect_to :controller => 'status' , :action => 'index'
  end

  def permite_edicao_exclusao
    if @status.padrao
      flash[:warning] = "Edição e/ou Exclusão não permitida para status padrão do sistema."
      return false
    else
      return true
    end
  end

end
