# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe ClienteContatosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => ClienteContato.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ClienteContato.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ClienteContato.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(cliente_contato_url(assigns[:cliente_contato]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => ClienteContato.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    ClienteContato.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ClienteContato.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ClienteContato.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ClienteContato.first
    response.should redirect_to(cliente_contato_url(assigns[:cliente_contato]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    cliente_contato = ClienteContato.first
    delete :destroy, :id => cliente_contato
    response.should redirect_to(cliente_contatos_url)
    ClienteContato.exists?(cliente_contato.id).should be_false
  end
end
