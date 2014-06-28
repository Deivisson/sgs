require 'spec_helper'

describe "cliente_infras/index.html.erb" do
  before(:each) do
    assign(:cliente_infras, [
      stub_model(ClienteInfra,
        :tipo_servidor => 1,
        :sistema_operacional => "Sistema_operacional",
        :banco_dados => "Banco_dados",
        :numero_estacoes => 1,
        :solucao_backup => false,
        :servidor_com_ride => false,
        :tipo_servidor => 1,
        :nome_empresa_ti => "Nome_empresa_ti",
        :responsavel_ti => "Responsavel_ti",
        :telefone => "Telefone",
        :email => "Email",
        :observacao => "Observacao"
      ),
      stub_model(ClienteInfra,
        :tipo_servidor => 1,
        :sistema_operacional => "Sistema_operacional",
        :banco_dados => "Banco_dados",
        :numero_estacoes => 1,
        :solucao_backup => false,
        :servidor_com_ride => false,
        :tipo_servidor => 1,
        :nome_empresa_ti => "Nome_empresa_ti",
        :responsavel_ti => "Responsavel_ti",
        :telefone => "Telefone",
        :email => "Email",
        :observacao => "Observacao"
      )
    ])
  end

  it "renders a list of cliente_infras" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sistema_operacional".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Banco_dados".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome_empresa_ti".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Responsavel_ti".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telefone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Observacao".to_s, :count => 2
  end
end
