class Etapa < ActiveRecord::Base
  
  DESENVOLVIMENTO = 1
  TREINAMENTO = 2
  INSTALACAO = 3
  
  has_and_belongs_to_many :projetos
  has_many :solicitacoes
  
end