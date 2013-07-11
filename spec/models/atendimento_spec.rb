# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Atendimento do
  before(:each) do
    @valid_attributes = {
      :cliente_id => 1,
      :usuario_cadastrante_id => 1,
      :usuario_solicitante_id => 1,
      :descricao => "value for descricao",
      :observacao => "value for observacao"
    }
  end

  it "should create a new instance given valid attributes" do
    Atendimento.create!(@valid_attributes)
  end
end
