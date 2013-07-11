require 'spec_helper'

describe "ordem_servicos/show.html.erb" do
  before(:each) do
    @ordem_servico = assign(:ordem_servico, stub_model(OrdemServico,
      :cliente => nil,
      :local_execucao => "Local_execucao",
      :cliente_contato => nil,
      :tipo_os => 1,
      :usuario => nil,
      :descricao => "MyText",
      :observacoes => "MyText",
      :usuarios_participantes => "Usuarios_participantes",
      :valor => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Local_execucao/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Usuarios_participantes/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
  end
end
