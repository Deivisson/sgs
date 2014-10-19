require "spec_helper"

describe CategoriaClientesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/categoria_clientes" }.should route_to(:controller => "categoria_clientes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/categoria_clientes/new" }.should route_to(:controller => "categoria_clientes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/categoria_clientes/1" }.should route_to(:controller => "categoria_clientes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/categoria_clientes/1/edit" }.should route_to(:controller => "categoria_clientes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/categoria_clientes" }.should route_to(:controller => "categoria_clientes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/categoria_clientes/1" }.should route_to(:controller => "categoria_clientes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/categoria_clientes/1" }.should route_to(:controller => "categoria_clientes", :action => "destroy", :id => "1")
    end

  end
end
