# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsuarioConfigsController do
  fixtures :all
  integrate_views
  
  it "show action should render show template" do
    get :show, :id => UsuarioConfig.first
    response.should render_template(:show)
  end
  
  it "edit action should render edit template" do
    get :edit, :id => UsuarioConfig.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    UsuarioConfig.any_instance.stubs(:valid?).returns(false)
    put :update, :id => UsuarioConfig.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    UsuarioConfig.any_instance.stubs(:valid?).returns(true)
    put :update, :id => UsuarioConfig.first
    response.should redirect_to(usuario_config_url(assigns[:usuario_config]))
  end
end
