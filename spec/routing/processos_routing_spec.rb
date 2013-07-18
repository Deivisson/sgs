require "spec_helper"

describe EtapasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/etapas" }.should route_to(:controller => "etapas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/etapas/new" }.should route_to(:controller => "etapas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/etapas/1" }.should route_to(:controller => "etapas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/etapas/1/edit" }.should route_to(:controller => "etapas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/etapas" }.should route_to(:controller => "etapas", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/etapas/1" }.should route_to(:controller => "etapas", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/etapas/1" }.should route_to(:controller => "etapas", :action => "destroy", :id => "1")
    end

  end
end
