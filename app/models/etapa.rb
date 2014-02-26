class Etapa < ActiveRecord::Base
  
  DESENVOLVIMENTO = 1
  TREINAMENTO = 2
  INSTALACAO = 3
  
  
  has_many :solicitacoes
  has_many :etapas_projetos
  has_many :projetos, through: :etapas_projetos

  attr_reader :context, :peso
  default_scope :order => "ordem asc"

  def percentual_participacao_projeto
  	solicitacoes.sum(:peso)
  end

  def percentual
  	return 30
  end

  def contexto
  	@contexto ||= self.descricao.remover_acentos.downcase
  end
end