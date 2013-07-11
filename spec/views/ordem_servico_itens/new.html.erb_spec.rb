require 'spec_helper'

describe "ordem_servico_itens/new.html.erb" do
  before(:each) do
    assign(:ordem_servico_item, stub_model(OrdemServicoItem,
      :ordem_servico => nil,
      :solucao_sub_modulo => nil,
      :tipo_avaliacao => nil,
      :situacao => nil,
      :usuarios => "MyString",
      :setor => "MyString"
    ).as_new_record)
  end

  it "renders new ordem_servico_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ordem_servico_itens_path, :method => "post" do
      assert_select "input#ordem_servico_item_ordem_servico", :name => "ordem_servico_item[ordem_servico]"
      assert_select "input#ordem_servico_item_projeto_sub_modulo", :name => "ordem_servico_item[projeto_sub_modulo]"
      assert_select "input#ordem_servico_item_tipo_avaliacao", :name => "ordem_servico_item[tipo_avaliacao]"
      assert_select "input#ordem_servico_item_situacao", :name => "ordem_servico_item[situacao]"
      assert_select "input#ordem_servico_item_usuarios", :name => "ordem_servico_item[usuarios]"
      assert_select "input#ordem_servico_item_setor", :name => "ordem_servico_item[setor]"
    end
  end
end
