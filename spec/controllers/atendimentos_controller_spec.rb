# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe AtendimentosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Atendimento.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Atendimento.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Atendimento.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(Atendimento_url(assigns[:Atendimento]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Atendimento.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Atendimento.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Atendimento.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Atendimento.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Atendimento.first
    response.should redirect_to(Atendimento_url(assigns[:Atendimento]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    Atendimento = Atendimento.first
    delete :destroy, :id => Atendimento
    response.should redirect_to(Atendimentos_url)
    Atendimento.exists?(Atendimento.id).should be_false
  end
end
