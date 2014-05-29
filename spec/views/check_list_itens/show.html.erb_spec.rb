require 'spec_helper'

describe "check_list_itens/show.html.erb" do
  before(:each) do
    @check_list_item = assign(:check_list_item, stub_model(CheckListItem,
      :descricao => "Descricao"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
  end
end
