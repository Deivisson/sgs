require 'spec_helper'

describe "cliente_check_list_itens/show.html.erb" do
  before(:each) do
    @cliente_check_list_item = assign(:cliente_check_list_item, stub_model(ClienteCheckListItem,
      :check_list_item => nil,
      :cliente => nil,
      :disponivel => false,
      :motivo => "Motivo",
      :responsavel => 1,
      :nome_responsavel => "Nome_responsavel"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Motivo/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome_responsavel/)
  end
end
