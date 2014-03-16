# -*- encoding : utf-8 -*-
class ProjetoProgramacaoTreinamento < ActiveRecord::Base

	validates_associated :projeto, :presence => true
	validates :usuario_id, :presence => true
	validates :data_programacao, :presence => true
	validates :hora_programacao, :presence => true
	validates :participantes, :presence => true, length: {maximum: 200}

  belongs_to :projeto
  belongs_to :usuario
  has_and_belongs_to_many :solucao_sub_modulos

  def controle
  	self.id.to_s.rjust(6,'0')
  end
end
