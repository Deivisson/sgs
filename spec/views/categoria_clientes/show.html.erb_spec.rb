require 'spec_helper'

describe "categoria_clientes/show.html.erb" do
  before(:each) do
    @categoria_cliente = assign(:categoria_cliente, stub_model(CategoriaCliente,
      :descricao => "Descricao"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
  end
end
