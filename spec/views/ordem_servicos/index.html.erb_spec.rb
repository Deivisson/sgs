require 'spec_helper'

describe "ordem_servicos/index.html.erb" do
  before(:each) do
    assign(:ordem_servicos, [
      stub_model(OrdemServico,
        :cliente => nil,
        :local_execucao => "Local_execucao",
        :cliente_contato => nil,
        :tipo_os => 1,
        :usuario => nil,
        :descricao => "MyText",
        :observacoes => "MyText",
        :usuarios_participantes => "Usuarios_participantes",
        :valor => "9.99"
      ),
      stub_model(OrdemServico,
        :cliente => nil,
        :local_execucao => "Local_execucao",
        :cliente_contato => nil,
        :tipo_os => 1,
        :usuario => nil,
        :descricao => "MyText",
        :observacoes => "MyText",
        :usuarios_participantes => "Usuarios_participantes",
        :valor => "9.99"
      )
    ])
  end

  it "renders a list of ordem_servicos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Local_execucao".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Usuarios_participantes".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
