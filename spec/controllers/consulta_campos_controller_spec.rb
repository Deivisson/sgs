# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe ConsultaCamposController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => ConsultaCampo.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ConsultaCampo.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ConsultaCampo.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(consulta_campo_url(assigns[:consulta_campo]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => ConsultaCampo.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    ConsultaCampo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ConsultaCampo.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ConsultaCampo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ConsultaCampo.first
    response.should redirect_to(consulta_campo_url(assigns[:consulta_campo]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    consulta_campo = ConsultaCampo.first
    delete :destroy, :id => consulta_campo
    response.should redirect_to(consulta_campos_url)
    ConsultaCampo.exists?(consulta_campo.id).should be_false
  end
end
