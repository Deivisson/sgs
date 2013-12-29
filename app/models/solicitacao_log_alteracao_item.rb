class SolicitacaoLogAlteracaoItem < ActiveRecord::Base
  belongs_to :solicitacao_log_alteracao
  attr_accessible :campo, :descricao
end
