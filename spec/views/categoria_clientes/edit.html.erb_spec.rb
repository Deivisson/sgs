require 'spec_helper'

describe "categoria_clientes/edit.html.erb" do
  before(:each) do
    @categoria_cliente = assign(:categoria_cliente, stub_model(CategoriaCliente,
      :descricao => "MyString"
    ))
  end

  it "renders the edit categoria_cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categoria_clientes_path(@categoria_cliente), :method => "post" do
      assert_select "input#categoria_cliente_descricao", :name => "categoria_cliente[descricao]"
    end
  end
end
