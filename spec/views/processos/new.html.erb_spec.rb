require 'spec_helper'

describe "etapas/new.html.erb" do
  before(:each) do
    assign(:etapa, stub_model(Etapa,
      :descricao => "MyString",
      :pontos_funcao => 1
    ).as_new_record)
  end

  it "renders new etapa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => etapas_path, :method => "post" do
      assert_select "input#etapa_descricao", :name => "etapa[descricao]"
      assert_select "input#etapa_pontos_funcao", :name => "etapa[pontos_funcao]"
    end
  end
end
