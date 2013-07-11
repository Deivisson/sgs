require 'spec_helper'

describe "ordem_servico_itens/show.html.erb" do
  before(:each) do
    @ordem_servico_item = assign(:ordem_servico_item, stub_model(OrdemServicoItem,
      :ordem_servico => nil,
      :solucao_sub_modulo => nil,
      :tipo_avaliacao => nil,
      :situacao => nil,
      :usuarios => "Usuarios",
      :setor => "Setor"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Usuarios/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Setor/)
  end
end
