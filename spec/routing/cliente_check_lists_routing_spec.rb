require "spec_helper"

describe ClienteCheckListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/cliente_check_lists" }.should route_to(:controller => "cliente_check_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cliente_check_lists/new" }.should route_to(:controller => "cliente_check_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cliente_check_lists/1" }.should route_to(:controller => "cliente_check_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cliente_check_lists/1/edit" }.should route_to(:controller => "cliente_check_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cliente_check_lists" }.should route_to(:controller => "cliente_check_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cliente_check_lists/1" }.should route_to(:controller => "cliente_check_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cliente_check_lists/1" }.should route_to(:controller => "cliente_check_lists", :action => "destroy", :id => "1")
    end

  end
end
