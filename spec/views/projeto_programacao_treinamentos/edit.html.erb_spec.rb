require 'spec_helper'

describe "projeto_programacao_treinamentos/edit.html.erb" do
  before(:each) do
    @projeto_programacao_treinamento = assign(:projeto_programacao_treinamento, stub_model(ProjetoProgramacaoTreinamento,
      :projeto => nil,
      :usuario => nil,
      :participantes => "MyString"
    ))
  end

  it "renders the edit projeto_programacao_treinamento form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projeto_programacao_treinamentos_path(@projeto_programacao_treinamento), :method => "post" do
      assert_select "input#projeto_programacao_treinamento_projeto", :name => "projeto_programacao_treinamento[projeto]"
      assert_select "input#projeto_programacao_treinamento_usuario", :name => "projeto_programacao_treinamento[usuario]"
      assert_select "input#projeto_programacao_treinamento_participantes", :name => "projeto_programacao_treinamento[participantes]"
    end
  end
end
