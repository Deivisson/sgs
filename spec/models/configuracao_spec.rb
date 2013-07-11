# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Configuracao do
  before(:each) do
    @valid_attributes = {
      :atendimento_padrao_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Configuracao.create!(@valid_attributes)
  end
end
