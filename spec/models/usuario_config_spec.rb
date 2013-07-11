# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe UsuarioConfig do
  it "should be valid" do
    UsuarioConfig.new.should be_valid
  end
end
