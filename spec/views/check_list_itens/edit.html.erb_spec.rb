require 'spec_helper'

describe "check_list_itens/edit.html.erb" do
  before(:each) do
    @check_list_item = assign(:check_list_item, stub_model(CheckListItem,
      :descricao => "MyString"
    ))
  end

  it "renders the edit check_list_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => check_list_itens_path(@check_list_item), :method => "post" do
      assert_select "input#check_list_item_descricao", :name => "check_list_item[descricao]"
    end
  end
end
