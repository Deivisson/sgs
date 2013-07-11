# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe VersaoSistema do
  it "should be valid" do
    VersaoSistema.new.should be_valid
  end
end
