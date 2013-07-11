# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Empresa do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :cnpj => "value for cnpj",
      :endereco => "value for endereco",
      :complemento => "value for complemento",
      :cidade => "value for cidade",
      :uf => "value for uf"
    }
  end

  it "should create a new instance given valid attributes" do
    Empresa.create!(@valid_attributes)
  end
end
