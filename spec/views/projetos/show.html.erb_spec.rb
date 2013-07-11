require 'spec_helper'

describe "projetos/show.html.erb" do
  before(:each) do
    @projeto = assign(:projeto, stub_model(Projeto,
      :nome => "Nome",
      :descricao => "Descricao",
      :cliente => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
