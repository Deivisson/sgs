require 'spec_helper'

describe "cliente_check_list_itens/edit.html.erb" do
  before(:each) do
    @cliente_check_list_item = assign(:cliente_check_list_item, stub_model(ClienteCheckListItem,
      :check_list_item => nil,
      :cliente => nil,
      :disponivel => false,
      :motivo => "MyString",
      :responsavel => 1,
      :nome_responsavel => "MyString"
    ))
  end

  it "renders the edit cliente_check_list_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cliente_check_lists_path(@cliente_check_list_item), :method => "post" do
      assert_select "input#cliente_check_list_check_list_item", :name => "cliente_check_list_item[check_list_item]"
      assert_select "input#cliente_check_list_cliente", :name => "cliente_check_list_item[cliente]"
      assert_select "input#cliente_check_list_disponivel", :name => "cliente_check_list_item[disponivel]"
      assert_select "input#cliente_check_list_motivo", :name => "cliente_check_list_item[motivo]"
      assert_select "input#cliente_check_list_responsavel", :name => "cliente_check_list_item[responsavel]"
      assert_select "input#cliente_check_list_nome_responsavel", :name => "cliente_check_list_item[nome_responsavel]"
    end
  end
end
