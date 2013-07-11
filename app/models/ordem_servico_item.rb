class OrdemServicoItem < ActiveRecord::Base

	validates :setor, :presence => true, :length => {:maximum => 30}
	validates :usuarios, :presence => true, :length => {:maximum => 30}
	
	belongs_to :ordem_servico
	belongs_to :solucao_sub_modulo
	belongs_to :tipo_avaliacao
	belongs_to :situacao
	
	attr_accessor :solucao_modulo_id	 
	
	def descricao_modulo
		return "" if self.solucao_sub_modulo.nil?
		self.solucao_sub_modulo.solucao_modulo.descricao
	end

end
