require "spec_helper"

describe ProcessosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/processos" }.should route_to(:controller => "processos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/processos/new" }.should route_to(:controller => "processos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/processos/1" }.should route_to(:controller => "processos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/processos/1/edit" }.should route_to(:controller => "processos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/processos" }.should route_to(:controller => "processos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/processos/1" }.should route_to(:controller => "processos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/processos/1" }.should route_to(:controller => "processos", :action => "destroy", :id => "1")
    end

  end
end
