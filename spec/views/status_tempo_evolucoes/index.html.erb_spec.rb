require 'spec_helper'

describe "status_tempo_evolucoes/index.html.erb" do
  before(:each) do
    assign(:status_tempo_evolucoes, [
      stub_model(StatusTempoEvolucao,
        :status => nil,
        :tipo_pendencia => nil,
        :prioridade => nil,
        :tempo_minutos => 1
      ),
      stub_model(StatusTempoEvolucao,
        :status => nil,
        :tipo_pendencia => nil,
        :prioridade => nil,
        :tempo_minutos => 1
      )
    ])
  end

  it "renders a list of status_tempo_evolucoes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
