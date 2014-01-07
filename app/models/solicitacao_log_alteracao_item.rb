class SolicitacaoLogAlteracaoItem < ActiveRecord::Base
  belongs_to :solicitacao_log_alteracao
  attr_accessible :campo, :velho_conteudo, :novo_conteudo

  def descricao
  	"De:#{velho_conteudo} <br> Para:#{novo_conteudo}"
  end
end
