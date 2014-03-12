require 'spec_helper'

describe "projeto_programacao_treinamentos/show.html.erb" do
  before(:each) do
    @projeto_programacao_treinamento = assign(:projeto_programacao_treinamento, stub_model(ProjetoProgramacaoTreinamento,
      :projeto => nil,
      :usuario => nil,
      :participantes => "Participantes"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Participantes/)
  end
end
