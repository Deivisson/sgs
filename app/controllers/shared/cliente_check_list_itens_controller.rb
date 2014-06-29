class Shared::ClienteCheckListItensController < Shared::BaseController

  def edit
    @cliente_check_list_itens = ClienteCheckListItem.where(cliente_id:params[:cliente_id])
  end

  def update
    @cliente_check_list_itens = []
    items =  params["check_lists"].first
    items.each do |i,v|
      @cliente_check_list_item = ClienteCheckListItem.find(i)
      @cliente_check_list_item.update_attributes(v)
      @cliente_check_list_itens << @cliente_check_list_item
    end
    respond_with(@cliente_check_list_itens)
  end
  # def destroy
  #   @cliente_check_list_item = ClienteCheckListItem.find(params[:id])
  #   @cliente_check_list_item.destroy
  #   respond_with(@cliente_check_list_item)
  # end
end
