require 'spec_helper'

describe "processos/index.html.erb" do
  before(:each) do
    assign(:processos, [
      stub_model(Processo,
        :descricao => "Descricao",
        :pontos_funcao => 1
      ),
      stub_model(Processo,
        :descricao => "Descricao",
        :pontos_funcao => 1
      )
    ])
  end

  it "renders a list of processos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
