# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe PrioridadesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Prioridade.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Prioridade.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Prioridade.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(prioridade_url(assigns[:prioridade]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Prioridade.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Prioridade.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Prioridade.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Prioridade.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Prioridade.first
    response.should redirect_to(prioridade_url(assigns[:prioridade]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    prioridade = Prioridade.first
    delete :destroy, :id => prioridade
    response.should redirect_to(prioridades_url)
    Prioridade.exists?(prioridade.id).should be_false
  end
end
