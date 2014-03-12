require 'spec_helper'

describe "projeto_programacao_treinamentos/index.html.erb" do
  before(:each) do
    assign(:projeto_programacao_treinamentos, [
      stub_model(ProjetoProgramacaoTreinamento,
        :projeto => nil,
        :usuario => nil,
        :participantes => "Participantes"
      ),
      stub_model(ProjetoProgramacaoTreinamento,
        :projeto => nil,
        :usuario => nil,
        :participantes => "Participantes"
      )
    ])
  end

  it "renders a list of projeto_programacao_treinamentos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Participantes".to_s, :count => 2
  end
end
