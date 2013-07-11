# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UsuarioCargo do
  before(:each) do
    @valid_attributes = {
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    UsuarioCargo.create!(@valid_attributes)
  end
end
