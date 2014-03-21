class Tarefa < ActiveRecord::Base
  
	validates :usuario_id, :presence => true
	validates :solicitacao_id, :presence => true

  belongs_to :usuario
  belongs_to :solicitacao

  attr_accessor :nivel_complexidade, :peso,:previsao_duracao_horas,:gera_cobranca,:valor_cobranca #, :to => :solicitacao

  after_save :atualiza_solicitacao 

  def nivel_complexidade
		@nivel_complexidade || self.solicitacao.nivel_complexidade
  end

  def peso
  	@peso || self.solicitacao.peso
  end

  def previsao_duracao_horas
  	@previsao_duracao_horas || self.solicitacao.previsao_duracao_horas
  end

  def gera_cobranca
  	@gera_cobranca || self.solicitacao.gera_cobranca
  end

  def valor_cobranca
  	@valor_cobranca || self.solicitacao.valor_cobranca
  end

private

	def atualiza_solicitacao
		attributes = {
			nivel_complexidade:nivel_complexidade,
			peso:peso,
			previsao_duracao_horas:previsao_duracao_horas,
			gera_cobranca:gera_cobranca,
			valor_cobranca:valor_cobranca
		}
		self.solicitacao.update_attributes(attributes)
	end
end
