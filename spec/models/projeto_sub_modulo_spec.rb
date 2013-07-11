# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SolucaoSubModulo do
  before(:each) do
    @valid_attributes = {
      :solucao_modulo_id => 1,
      :descricao => "value for descricao",
      :detalhe => "value for detalhe",
      :data_criacao => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    SolucaoSubModulo.create!(@valid_attributes)
  end
end
