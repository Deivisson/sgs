require "spec_helper"

describe ProjetoProgramacaoTreinamentosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/projeto_programacao_treinamentos" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/projeto_programacao_treinamentos/new" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/projeto_programacao_treinamentos/1" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/projeto_programacao_treinamentos/1/edit" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/projeto_programacao_treinamentos" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/projeto_programacao_treinamentos/1" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/projeto_programacao_treinamentos/1" }.should route_to(:controller => "projeto_programacao_treinamentos", :action => "destroy", :id => "1")
    end

  end
end
