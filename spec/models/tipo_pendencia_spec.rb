# -*- encoding : utf-8 -*-
require 'spec_helper'

describe TipoPendencia do
  before(:each) do
    @valid_attributes = {
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    TipoPendencia.create!(@valid_attributes)
  end
end
