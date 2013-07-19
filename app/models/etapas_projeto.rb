class EtapasProjeto < ActiveRecord::Base
	belongs_to :projeto
	belongs_to :etapa

  attr_reader :peso, :peso_concluido_etapa

  def peso
    solicitacoes = recupera_solicitacoes_etapa
    @peso ||= solicitacoes.sum(:peso) 
  end

  def peso_concluido_etapa
  	solicitacoes = recupera_solicitacoes_etapa
  	solicitacoes = solicitacoes.joins(:status).where("status.encerramento = ?",true)
		@peso_concluido_etapa ||= solicitacoes.sum(:peso)	
  end

  def participacao_projeto
    return 0  if self.projeto.peso_total == 0
  	resultado = peso.to_f / self.projeto.peso_total.to_f
    return (resultado * 100).round(2)
  end

  def progresso
  	return 0 if peso  == 0
  	resultado = peso_concluido_etapa.to_f / peso.to_f
    return (resultado * 100).round(2)
  end

private 
	def recupera_solicitacoes_etapa
		self.projeto.send("solicitacoes_etapa_#{self.etapa.contexto}")
	end
end