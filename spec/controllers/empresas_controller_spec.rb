# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe EmpresasController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Empresa.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Empresa.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Empresa.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(empresa_url(assigns[:empresa]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Empresa.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Empresa.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Empresa.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Empresa.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Empresa.first
    response.should redirect_to(empresa_url(assigns[:empresa]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    empresa = Empresa.first
    delete :destroy, :id => empresa
    response.should redirect_to(empresas_url)
    Empresa.exists?(empresa.id).should be_false
  end
end
