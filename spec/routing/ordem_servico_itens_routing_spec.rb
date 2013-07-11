require "spec_helper"

describe OrdemServicoItensController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ordem_servico_itens" }.should route_to(:controller => "ordem_servico_itens", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ordem_servico_itens/new" }.should route_to(:controller => "ordem_servico_itens", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ordem_servico_itens/1" }.should route_to(:controller => "ordem_servico_itens", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ordem_servico_itens/1/edit" }.should route_to(:controller => "ordem_servico_itens", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ordem_servico_itens" }.should route_to(:controller => "ordem_servico_itens", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ordem_servico_itens/1" }.should route_to(:controller => "ordem_servico_itens", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ordem_servico_itens/1" }.should route_to(:controller => "ordem_servico_itens", :action => "destroy", :id => "1")
    end

  end
end
