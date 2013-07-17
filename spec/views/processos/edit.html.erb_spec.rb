require 'spec_helper'

describe "processos/edit.html.erb" do
  before(:each) do
    @processo = assign(:processo, stub_model(Processo,
      :descricao => "MyString",
      :pontos_funcao => 1
    ))
  end

  it "renders the edit processo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => processos_path(@processo), :method => "post" do
      assert_select "input#processo_descricao", :name => "processo[descricao]"
      assert_select "input#processo_pontos_funcao", :name => "processo[pontos_funcao]"
    end
  end
end
