require 'spec_helper'

describe "etapas/index.html.erb" do
  before(:each) do
    assign(:etapas, [
      stub_model(Etapa,
        :descricao => "Descricao",
        :pontos_funcao => 1
      ),
      stub_model(Etapa,
        :descricao => "Descricao",
        :pontos_funcao => 1
      )
    ])
  end

  it "renders a list of etapas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
