require 'spec_helper'

describe "check_list_itens/index.html.erb" do
  before(:each) do
    assign(:check_list_itens, [
      stub_model(CheckListItem,
        :descricao => "Descricao"
      ),
      stub_model(CheckListItem,
        :descricao => "Descricao"
      )
    ])
  end

  it "renders a list of check_list_itens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
  end
end
