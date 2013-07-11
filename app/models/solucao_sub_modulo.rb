# -*- encoding : utf-8 -*-
class SolucaoSubModulo < ActiveRecord::Base
  validates_presence_of :solucao_modulo_id, :descricao

  validate :valida_descricao

  validates_length_of :descricao, :maximum => 50
  validates_length_of :detalhe, :maximum => 255, :allow_blank => true

  validates_associated :ordem_servico_itens
  
  belongs_to :solucao_modulo
  has_many :pendencia_itens
  has_many :ordem_servico_itens
  
  scope :to_select_by_modulo, lambda{|modulo_id|{
    :select => 'id,descricao',
    :conditions => ['solucao_modulo_id = ? ',modulo_id],
    :order => :descricao
  }}
  
  #Apenas gera excessao se descricao informada já tiver sido cadastrada para 
  #o modulo selecionado.
  def valida_descricao
    i = 0
    i = id if not id.nil?
    ps = SolucaoSubModulo.find_by_descricao(descricao,:conditions => ['solucao_modulo_id = ? and id <> ?', solucao_modulo_id,i])  
    errors.add(:descricao,'Sub Módulo já cadastrado.') if not ps.nil?
  end

end
