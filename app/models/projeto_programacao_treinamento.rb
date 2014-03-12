class ProjetoProgramacaoTreinamento < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :tecnico, class_name: 'Usuario'
  has_and_belongs_to_many :solucao_sub_modulos #, class_name:'ProjetoProgramacaoTreinamentosSolucaoSubModulos'
end
