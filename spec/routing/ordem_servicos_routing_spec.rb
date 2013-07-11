require "spec_helper"

describe OrdemServicosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ordem_servicos" }.should route_to(:controller => "ordem_servicos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ordem_servicos/new" }.should route_to(:controller => "ordem_servicos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ordem_servicos/1" }.should route_to(:controller => "ordem_servicos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ordem_servicos/1/edit" }.should route_to(:controller => "ordem_servicos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ordem_servicos" }.should route_to(:controller => "ordem_servicos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ordem_servicos/1" }.should route_to(:controller => "ordem_servicos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ordem_servicos/1" }.should route_to(:controller => "ordem_servicos", :action => "destroy", :id => "1")
    end

  end
end
