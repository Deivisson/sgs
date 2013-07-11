# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe SolucaoModulosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => SolucaoModulo.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    SolucaoModulo.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    SolucaoModulo.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(projeto_modulo_url(assigns[:solucao_modulo]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => SolucaoModulo.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    SolucaoModulo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SolucaoModulo.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    SolucaoModulo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SolucaoModulo.first
    response.should redirect_to(projeto_modulo_url(assigns[:solucao_modulo]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    projeto_modulo = SolucaoModulo.first
    delete :destroy, :id => projeto_modulo
    response.should redirect_to(projeto_modulos_url)
    SolucaoModulo.exists?(projeto_modulo.id).should be_false
  end
end
