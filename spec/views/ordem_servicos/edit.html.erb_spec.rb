require 'spec_helper'

describe "ordem_servicos/edit.html.erb" do
  before(:each) do
    @ordem_servico = assign(:ordem_servico, stub_model(OrdemServico,
      :cliente => nil,
      :local_execucao => "MyString",
      :cliente_contato => nil,
      :tipo_os => 1,
      :usuario => nil,
      :descricao => "MyText",
      :observacoes => "MyText",
      :usuarios_participantes => "MyString",
      :valor => "9.99"
    ))
  end

  it "renders the edit ordem_servico form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ordem_servicos_path(@ordem_servico), :method => "post" do
      assert_select "input#ordem_servico_cliente", :name => "ordem_servico[cliente]"
      assert_select "input#ordem_servico_local_execucao", :name => "ordem_servico[local_execucao]"
      assert_select "input#ordem_servico_cliente_contato", :name => "ordem_servico[cliente_contato]"
      assert_select "input#ordem_servico_tipo_os", :name => "ordem_servico[tipo_os]"
      assert_select "input#ordem_servico_usuario", :name => "ordem_servico[usuario]"
      assert_select "textarea#ordem_servico_descricao", :name => "ordem_servico[descricao]"
      assert_select "textarea#ordem_servico_observacoes", :name => "ordem_servico[observacoes]"
      assert_select "input#ordem_servico_usuarios_participantes", :name => "ordem_servico[usuarios_participantes]"
      assert_select "input#ordem_servico_valor", :name => "ordem_servico[valor]"
    end
  end
end
