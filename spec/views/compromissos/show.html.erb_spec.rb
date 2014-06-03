require 'spec_helper'

describe "compromissos/show.html.erb" do
  before(:each) do
    @compromisso = assign(:compromisso, stub_model(Compromisso,
      :usuario => nil,
      :descricao => "MyText",
      :usuario_cadastrante_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
