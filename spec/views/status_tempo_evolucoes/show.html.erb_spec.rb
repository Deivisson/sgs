require 'spec_helper'

describe "status_tempo_evolucoes/show.html.erb" do
  before(:each) do
    @status_tempo_evolucao = assign(:status_tempo_evolucao, stub_model(StatusTempoEvolucao,
      :status => nil,
      :tipo_pendencia => nil,
      :prioridade => nil,
      :tempo_minutos => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
