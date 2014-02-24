require 'spec_helper'

describe "status_tempo_evolucoes/edit.html.erb" do
  before(:each) do
    @status_tempo_evolucao = assign(:status_tempo_evolucao, stub_model(StatusTempoEvolucao,
      :status => nil,
      :tipo_pendencia => nil,
      :prioridade => nil,
      :tempo_minutos => 1
    ))
  end

  it "renders the edit status_tempo_evolucao form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => status_tempo_evolucoes_path(@status_tempo_evolucao), :method => "post" do
      assert_select "input#status_tempo_evolucao_status", :name => "status_tempo_evolucao[status]"
      assert_select "input#status_tempo_evolucao_tipo_pendencia", :name => "status_tempo_evolucao[tipo_pendencia]"
      assert_select "input#status_tempo_evolucao_prioridade", :name => "status_tempo_evolucao[prioridade]"
      assert_select "input#status_tempo_evolucao_tempo_minutos", :name => "status_tempo_evolucao[tempo_minutos]"
    end
  end
end
