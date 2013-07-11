# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SolicitacaoHistorico do
  before(:each) do
    @valid_attributes = {
      :usuario_id => 1,
      :solicitacao_id => 1,
      :detalhe => "value for detalhe"
    }
  end

  it "should create a new instance given valid attributes" do
    SolicitacaoHistorico.create!(@valid_attributes)
  end
end
