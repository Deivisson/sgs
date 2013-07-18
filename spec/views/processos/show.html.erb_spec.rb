require 'spec_helper'

describe "etapas/show.html.erb" do
  before(:each) do
    @etapa = assign(:etapa, stub_model(Etapa,
      :descricao => "Descricao",
      :pontos_funcao => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
