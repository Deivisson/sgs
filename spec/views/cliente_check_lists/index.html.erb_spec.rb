require 'spec_helper'

describe "cliente_check_list_itens/index.html.erb" do
  before(:each) do
    assign(:cliente_check_list_itens, [
      stub_model(ClienteCheckListItem,
        :check_list_item => nil,
        :cliente => nil,
        :disponivel => false,
        :motivo => "Motivo",
        :responsavel => 1,
        :nome_responsavel => "Nome_responsavel"
      ),
      stub_model(ClienteCheckListItem,
        :check_list_item => nil,
        :cliente => nil,
        :disponivel => false,
        :motivo => "Motivo",
        :responsavel => 1,
        :nome_responsavel => "Nome_responsavel"
      )
    ])
  end

  it "renders a list of cliente_check_list_itens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Motivo".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome_responsavel".to_s, :count => 2
  end
end
