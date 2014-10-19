require 'spec_helper'

describe "categoria_clientes/index.html.erb" do
  before(:each) do
    assign(:categoria_clientes, [
      stub_model(CategoriaCliente,
        :descricao => "Descricao"
      ),
      stub_model(CategoriaCliente,
        :descricao => "Descricao"
      )
    ])
  end

  it "renders a list of categoria_clientes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
  end
end
