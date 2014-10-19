require 'spec_helper'

describe "categoria_clientes/new.html.erb" do
  before(:each) do
    assign(:categoria_cliente, stub_model(CategoriaCliente,
      :descricao => "MyString"
    ).as_new_record)
  end

  it "renders new categoria_cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categoria_clientes_path, :method => "post" do
      assert_select "input#categoria_cliente_descricao", :name => "categoria_cliente[descricao]"
    end
  end
end
