require 'spec_helper'

describe "check_list_itens/new.html.erb" do
  before(:each) do
    assign(:check_list_item, stub_model(CheckListItem,
      :descricao => "MyString"
    ).as_new_record)
  end

  it "renders new check_list_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => check_list_itens_path, :method => "post" do
      assert_select "input#check_list_item_descricao", :name => "check_list_item[descricao]"
    end
  end
end
