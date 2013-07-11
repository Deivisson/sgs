# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ClienteContato do
  before(:each) do
    @valid_attributes = {
      :cliente_id => 1,
      :nome => "value for nome",
      :departamento => "value for departamento",
      :email => "value for email",
      :telefone => "value for telefone",
      :celular => "value for celular"
    }
  end

  it "should create a new instance given valid attributes" do
    ClienteContato.create!(@valid_attributes)
  end
end
