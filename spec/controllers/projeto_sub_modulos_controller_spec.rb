# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe SolucaoSubModulosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => SolucaoSubModulo.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    SolucaoSubModulo.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    SolucaoSubModulo.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(projeto_sub_modulo_url(assigns[:solucao_sub_modulo]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => SolucaoSubModulo.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    SolucaoSubModulo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SolucaoSubModulo.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    SolucaoSubModulo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SolucaoSubModulo.first
    response.should redirect_to(projeto_sub_modulo_url(assigns[:solucao_sub_modulo]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    projeto_sub_modulo = SolucaoSubModulo.first
    delete :destroy, :id => projeto_sub_modulo
    response.should redirect_to(projeto_sub_modulos_url)
    SolucaoSubModulo.exists?(projeto_sub_modulo.id).should be_false
  end
end
