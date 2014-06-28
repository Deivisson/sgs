require 'spec_helper'

describe "cliente_infras/show.html.erb" do
  before(:each) do
    @cliente_infra = assign(:cliente_infra, stub_model(ClienteInfra,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sistema_operacional/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Banco_dados/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome_empresa_ti/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Responsavel_ti/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Telefone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Observacao/)
  end
end
