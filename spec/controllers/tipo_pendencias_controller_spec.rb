# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe TipoPendenciasController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => TipoPendencia.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    TipoPendencia.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    TipoPendencia.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(tipo_pendencia_url(assigns[:tipo_pendencia]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => TipoPendencia.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    TipoPendencia.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TipoPendencia.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    TipoPendencia.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TipoPendencia.first
    response.should redirect_to(tipo_pendencia_url(assigns[:tipo_pendencia]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    tipo_pendencia = TipoPendencia.first
    delete :destroy, :id => tipo_pendencia
    response.should redirect_to(tipo_pendencias_url)
    TipoPendencia.exists?(tipo_pendencia.id).should be_false
  end
end
