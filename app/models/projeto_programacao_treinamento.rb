class ProjetoProgramacaoTreinamento < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :usuario #:tecnico, class_name: 'Usuario'
  has_and_belongs_to_many :solucao_sub_modulos #, class_name:'ProjetoProgramacaoTreinamentosSolucaoSubModulos'


  def controle
  	self.id.to_s.rjust(6,'0')
  end
end
