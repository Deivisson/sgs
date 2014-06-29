require 'spec_helper'

describe "cliente_check_lists/edit.html.erb" do
  before(:each) do
    @cliente_check_list = assign(:cliente_check_list, stub_model(ClienteCheckList,
      :check_list_item => nil,
      :cliente => nil,
      :disponivel => false,
      :motivo => "MyString",
      :responsavel => 1,
      :nome_responsavel => "MyString"
    ))
  end

  it "renders the edit cliente_check_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cliente_check_lists_path(@cliente_check_list), :method => "post" do
      assert_select "input#cliente_check_list_check_list_item", :name => "cliente_check_list[check_list_item]"
      assert_select "input#cliente_check_list_cliente", :name => "cliente_check_list[cliente]"
      assert_select "input#cliente_check_list_disponivel", :name => "cliente_check_list[disponivel]"
      assert_select "input#cliente_check_list_motivo", :name => "cliente_check_list[motivo]"
      assert_select "input#cliente_check_list_responsavel", :name => "cliente_check_list[responsavel]"
      assert_select "input#cliente_check_list_nome_responsavel", :name => "cliente_check_list[nome_responsavel]"
    end
  end
end
