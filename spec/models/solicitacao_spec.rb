# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Solicitacao do
  before(:each) do
    @valid_attributes = {
      :atendimento_id => 1,
      :status_id => 1,
      :prioridade_id => 1,
      :solucao_sub_modulo_id => 1,
      :cliente_contato_id => 1,
      :tipo_pendencia_id => 1,
      :titulo => "value for titulo",
      :detalhe => "value for detalhe",
      :data_previsao_liberacao => Date.today,
      :data_hora_real_liberacao => Time.now,
      :versao_liberacao => "value for versao_liberacao",
      :anexo => "value for anexo"
    }
  end

  it "should create a new instance given valid attributes" do
    Solicitacao.create!(@valid_attributes)
  end
end
