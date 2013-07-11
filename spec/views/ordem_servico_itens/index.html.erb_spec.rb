require 'spec_helper'

describe "ordem_servico_itens/index.html.erb" do
  before(:each) do
    assign(:ordem_servico_itens, [
      stub_model(OrdemServicoItem,
        :ordem_servico => nil,
        :solucao_sub_modulo => nil,
        :tipo_avaliacao => nil,
        :situacao => nil,
        :usuarios => "Usuarios",
        :setor => "Setor"
      ),
      stub_model(OrdemServicoItem,
        :ordem_servico => nil,
        :solucao_sub_modulo => nil,
        :tipo_avaliacao => nil,
        :situacao => nil,
        :usuarios => "Usuarios",
        :setor => "Setor"
      )
    ])
  end

  it "renders a list of ordem_servico_itens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Usuarios".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Setor".to_s, :count => 2
  end
end
