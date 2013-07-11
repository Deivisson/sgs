# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe SolicitacaoHistoricosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => SolicitacaoHistorico.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    SolicitacaoHistorico.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    SolicitacaoHistorico.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(pendencia_item_historico_url(assigns[:pendencia_item_historico]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => SolicitacaoHistorico.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    SolicitacaoHistorico.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SolicitacaoHistorico.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    SolicitacaoHistorico.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SolicitacaoHistorico.first
    response.should redirect_to(pendencia_item_historico_url(assigns[:pendencia_item_historico]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    pendencia_item_historico = SolicitacaoHistorico.first
    delete :destroy, :id => pendencia_item_historico
    response.should redirect_to(pendencia_item_historicos_url)
    SolicitacaoHistorico.exists?(pendencia_item_historico.id).should be_false
  end
end
