# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "/status_usuario_cargo/status_id:integer" do
  before(:each) do
    render 'status_usuario_cargo/status_id:integer'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/status_usuario_cargo/status_id:integer])
  end
end
