require 'spec_helper'

describe "ClienteCheckListItens" do
  describe "GET /cliente_check_list_itens" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get cliente_check_lists_path
      response.status.should be(200)
    end
  end
end
