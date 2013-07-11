# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe Usuario do
  it "should be valid" do
    Usuario.new.should be_valid
  end
end
