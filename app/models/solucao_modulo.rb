# -*- encoding : utf-8 -*-
class SolucaoModulo < ActiveRecord::Base
  validates_presence_of :solucao_id, :descricao

  validate :valida_descricao

  validates_length_of :descricao, :maximum => 50
  validates_length_of :detalhe, :maximum => 255, :allow_blank => true

  belongs_to :solucao
  has_many :solucao_sub_modulos

  scope :lista_modulos,
        :select => 'solucao_modulos.id,solucoes.descricao as solucao_descricao,solucao_modulos.descricao as modulo_descricao', 
        :joins =>[:solucao],
        :order => "solucoes.descricao"
  
  
  scope :for_group_options, lambda {|cliente_id|{
    :select     => "solucoes.descricao as desc_solucao, solucao_modulos.id, solucao_modulos.descricao as desc_modulo",
    :joins      => [:solucao => :clientes],
    :conditions => ["cliente_id = ? ", cliente_id],
    :order      => ["solucoes.descricao,solucao_modulos.descricao"]
  }}

  def peso_total
    self.solucao_sub_modulos.where("peso > 0").sum("peso")
  end  

  def tempo_previsto_treinamento
    minutos = self.solucao_sub_modulos.where("previsao_treinamento_minutos > 0").sum("previsao_treinamento_minutos")
    minutos_em_horas(minutos) 
  end

private   
  #Apenas gera excessao se descricao informada já tiver sido cadastrada para 
  #o solucao selecionado.
  def valida_descricao
    i = 0
    i = id if not id.nil?

    pm = SolucaoModulo.find_by_descricao(descricao,:conditions => ['solucao_id = ? and id <> ?',solucao_id,i])  
    errors.add(:descricao,'Módulo já cadastrado.') if not pm.nil?
  end

end
