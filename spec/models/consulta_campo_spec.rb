# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe ConsultaCampo do
  it "should be valid" do
    ConsultaCampo.new.should be_valid
  end
end
