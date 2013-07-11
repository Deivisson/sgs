# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SolucaoModulo do
  before(:each) do
    @valid_attributes = {
      :solucao_id => 1,
      :descricao => "value for descricao",
      :detalhe => "value for detalhe"
    }
  end

  it "should create a new instance given valid attributes" do
    SolucaoModulo.create!(@valid_attributes)
  end
end
