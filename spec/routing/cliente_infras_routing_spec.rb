require "spec_helper"

describe ClienteInfrasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/cliente_infras" }.should route_to(:controller => "cliente_infras", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cliente_infras/new" }.should route_to(:controller => "cliente_infras", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cliente_infras/1" }.should route_to(:controller => "cliente_infras", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cliente_infras/1/edit" }.should route_to(:controller => "cliente_infras", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cliente_infras" }.should route_to(:controller => "cliente_infras", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cliente_infras/1" }.should route_to(:controller => "cliente_infras", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cliente_infras/1" }.should route_to(:controller => "cliente_infras", :action => "destroy", :id => "1")
    end

  end
end
