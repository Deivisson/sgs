require 'spec_helper'

describe "CategoriaClientes" do
  describe "GET /categoria_clientes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get categoria_clientes_path
      response.status.should be(200)
    end
  end
end
