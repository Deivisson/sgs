require 'spec_helper'

describe "processos/show.html.erb" do
  before(:each) do
    @processo = assign(:processo, stub_model(Processo,
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
