require "spec_helper"

describe ProjetosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/projetos" }.should route_to(:controller => "projetos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/projetos/new" }.should route_to(:controller => "projetos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/projetos/1" }.should route_to(:controller => "projetos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/projetos/1/edit" }.should route_to(:controller => "projetos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/projetos" }.should route_to(:controller => "projetos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/projetos/1" }.should route_to(:controller => "projetos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/projetos/1" }.should route_to(:controller => "projetos", :action => "destroy", :id => "1")
    end

  end
end
