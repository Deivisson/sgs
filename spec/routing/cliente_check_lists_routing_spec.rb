require "spec_helper"

describe ClienteCheckListItensController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/cliente_check_list_itens" }.should route_to(:controller => "cliente_check_list_itens", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cliente_check_list_itens/new" }.should route_to(:controller => "cliente_check_list_itens", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cliente_check_list_itens/1" }.should route_to(:controller => "cliente_check_list_itens", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cliente_check_list_itens/1/edit" }.should route_to(:controller => "cliente_check_list_itens", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cliente_check_list_itens" }.should route_to(:controller => "cliente_check_list_itens", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cliente_check_list_itens/1" }.should route_to(:controller => "cliente_check_list_itens", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cliente_check_list_itens/1" }.should route_to(:controller => "cliente_check_list_itens", :action => "destroy", :id => "1")
    end

  end
end
