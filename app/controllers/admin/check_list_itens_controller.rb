# -*- encoding : utf-8 -*-
class Admin::CheckListItensController < Admin::BaseController

  before_filter :check_list_item, :except => [:index,:new, :create]

  def index
    @check_list_itens = CheckListItem.all
    respond_with(@check_list_itens)
  end

  def show
    respond_with(@check_list_item)
  end

  def new
    @check_list_item = CheckListItem.new
    respond_with(@check_list_item)
  end

  def edit; end

  def create
    @check_list_item = CheckListItem.new(params[:check_list_item])
    if @check_list_item.save
      respond_with(@check_list_item, :location => admin_check_list_itens_path)
    else
      render :new
    end 
  end

  def update
    @check_list_item.update_attributes(params[:check_list_item])
    respond_with(@check_list_item, :location => admin_check_list_item_path(@check_list_item))
  end

  def destroy
    @check_list_item.destroy
    respond_with(@check_list_item, :location => admin_check_list_itens_path)
  end

private
  def check_list_item
    @check_list_item = CheckListItem.find(params[:id])
  end
end
