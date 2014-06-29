class Shared::ClienteCheckListsController < Shared::BaseController
  def index
    @cliente_check_lists = ClienteCheckList.all
    respond_with(@cliente_check_lists)
  end

  def show
    @cliente_check_list = ClienteCheckList.find(params[:id])
    respond_with(@cliente_check_list)
  end

  def new
    @cliente_check_list = ClienteCheckList.new
    respond_with(@cliente_check_list)
  end

  def edit
    @cliente_check_lists = ClienteCheckList.all
  end

  def create
    @cliente_check_list = ClienteCheckList.new(params[:cliente_check_list])
    @cliente_check_list.save
    respond_with(@cliente_check_list)
  end

  def update
    @cliente_check_list = ClienteCheckList.find(params[:id])
    @cliente_check_list.update_attributes(params[:cliente_check_list])
    respond_with(@cliente_check_list)
  end

  def destroy
    @cliente_check_list = ClienteCheckList.find(params[:id])
    @cliente_check_list.destroy
    respond_with(@cliente_check_list)
  end
end
