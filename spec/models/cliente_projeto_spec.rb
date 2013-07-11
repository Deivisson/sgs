# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ClienteSolucao do
  before(:each) do
    @valid_attributes = {
      :cliente_id => 1,
      :solucao_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ClienteSolucao.create!(@valid_attributes)
  end
end
