# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsuariosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Usuario.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Usuario.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Usuario.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(usuario_url(assigns[:usuario]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Usuario.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Usuario.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Usuario.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Usuario.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Usuario.first
    response.should redirect_to(usuario_url(assigns[:usuario]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    usuario = Usuario.first
    delete :destroy, :id => usuario
    response.should redirect_to(usuarios_url)
    Usuario.exists?(usuario.id).should be_false
  end
end
