require 'spec_helper'

describe "projeto_programacao_treinamentos/new.html.erb" do
  before(:each) do
    assign(:projeto_programacao_treinamento, stub_model(ProjetoProgramacaoTreinamento,
      :projeto => nil,
      :usuario => nil,
      :participantes => "MyString"
    ).as_new_record)
  end

  it "renders new projeto_programacao_treinamento form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projeto_programacao_treinamentos_path, :method => "post" do
      assert_select "input#projeto_programacao_treinamento_projeto", :name => "projeto_programacao_treinamento[projeto]"
      assert_select "input#projeto_programacao_treinamento_usuario", :name => "projeto_programacao_treinamento[usuario]"
      assert_select "input#projeto_programacao_treinamento_participantes", :name => "projeto_programacao_treinamento[participantes]"
    end
  end
end
