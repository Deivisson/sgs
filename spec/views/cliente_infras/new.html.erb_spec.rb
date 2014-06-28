require 'spec_helper'

describe "cliente_infras/new.html.erb" do
  before(:each) do
    assign(:cliente_infra, stub_model(ClienteInfra,
      :tipo_servidor => 1,
      :sistema_operacional => "MyString",
      :banco_dados => "MyString",
      :numero_estacoes => 1,
      :solucao_backup => false,
      :servidor_com_ride => false,
      :tipo_servidor => 1,
      :nome_empresa_ti => "MyString",
      :responsavel_ti => "MyString",
      :telefone => "MyString",
      :email => "MyString",
      :observacao => "MyString"
    ).as_new_record)
  end

  it "renders new cliente_infra form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cliente_infras_path, :method => "post" do
      assert_select "input#cliente_infra_tipo_servidor", :name => "cliente_infra[tipo_servidor]"
      assert_select "input#cliente_infra_sistema_operacional", :name => "cliente_infra[sistema_operacional]"
      assert_select "input#cliente_infra_banco_dados", :name => "cliente_infra[banco_dados]"
      assert_select "input#cliente_infra_numero_estacoes", :name => "cliente_infra[numero_estacoes]"
      assert_select "input#cliente_infra_solucao_backup", :name => "cliente_infra[solucao_backup]"
      assert_select "input#cliente_infra_servidor_com_ride", :name => "cliente_infra[servidor_com_ride]"
      assert_select "input#cliente_infra_tipo_servidor", :name => "cliente_infra[tipo_servidor]"
      assert_select "input#cliente_infra_nome_empresa_ti", :name => "cliente_infra[nome_empresa_ti]"
      assert_select "input#cliente_infra_responsavel_ti", :name => "cliente_infra[responsavel_ti]"
      assert_select "input#cliente_infra_telefone", :name => "cliente_infra[telefone]"
      assert_select "input#cliente_infra_email", :name => "cliente_infra[email]"
      assert_select "input#cliente_infra_observacao", :name => "cliente_infra[observacao]"
    end
  end
end
