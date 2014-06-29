class Shared::ClienteInfrasController < Shared::BaseController
  before_filter :load_cliente_infra

  def show
    respond_with(@cliente_infra)
  end
  
  def edit; end

  def update
    @cliente_infra.update_attributes(params[:cliente_infra])
    respond_with(@cliente_infra, location:admin_cliente_path(@cliente_infra.cliente))
  end

private 
  def load_cliente_infra
    @cliente_infra = ClienteInfra.find(params[:id])
  end
end
