# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Cliente do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :endereco => "value for endereco",
      :complemento => "value for complemento",
      :bairro => "value for bairro",
      :cidade => "value for cidade",
      :uf => "value for uf",
      :cep => "value for cep",
      :telefone => "value for telefone",
      :fax => 
    }
  end

  it "should create a new instance given valid attributes" do
    Cliente.create!(@valid_attributes)
  end
end
