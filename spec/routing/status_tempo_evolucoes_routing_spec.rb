require "spec_helper"

describe StatusTempoEvolucoesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/status_tempo_evolucoes" }.should route_to(:controller => "status_tempo_evolucoes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/status_tempo_evolucoes/new" }.should route_to(:controller => "status_tempo_evolucoes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/status_tempo_evolucoes/1" }.should route_to(:controller => "status_tempo_evolucoes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/status_tempo_evolucoes/1/edit" }.should route_to(:controller => "status_tempo_evolucoes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/status_tempo_evolucoes" }.should route_to(:controller => "status_tempo_evolucoes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/status_tempo_evolucoes/1" }.should route_to(:controller => "status_tempo_evolucoes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/status_tempo_evolucoes/1" }.should route_to(:controller => "status_tempo_evolucoes", :action => "destroy", :id => "1")
    end

  end
end
