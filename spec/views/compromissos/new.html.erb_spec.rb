require 'spec_helper'

describe "compromissos/new.html.erb" do
  before(:each) do
    assign(:compromisso, stub_model(Agenda,
      :usuario => nil,
      :descricao => "MyText",
      :usuario_cadastrante_id => 1
    ).as_new_record)
  end

  it "renders new compromisso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => compromissos_path, :method => "post" do
      assert_select "input#compromisso_usuario", :name => "compromisso[usuario]"
      assert_select "textarea#compromisso_descricao", :name => "compromisso[descricao]"
      assert_select "input#compromisso_usuario_cadastrante_id", :name => "compromisso[usuario_cadastrante_id]"
    end
  end
end
