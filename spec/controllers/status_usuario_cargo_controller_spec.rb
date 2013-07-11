# -*- encoding : utf-8 -*-
require 'spec_helper'

describe StatusUsuarioCargoController do


  #Delete these examples and add some real ones

  it "should use StatusUsuarioCargoController" do
    controller.should be_an_instance_of(StatusUsuarioCargoController)
  end




  describe "GET 'status_id:integer'" do
    it "should be successful" do
      get 'status_id:integer'
      response.should be_success
    end
  end


  describe "GET 'usuario_cargo_id:integer'" do
    it "should be successful" do
      get 'usuario_cargo_id:integer'
      response.should be_success
    end
  end


end
