# -*- encoding : utf-8 -*-
class Status < ActiveRecord::Base
  
  ABERTO = 1
  EM_ANALISE = 2
  NAO_APROVADO = 3
  AG_DESENV = 4
  EM_DESENV = 5
  DESENV_INTER = 6
  AG_HOMOLOG = 7
  EM_HOMOLOG = 8
  HOMOLOG_REPROV = 9
  LIB_PUBLICACAO =  10
  PUBLICADO = 11

  ITENS = [ { :id => 1, :descricao => "aberto"},
            { :id => 2, :descricao => "em_analise"},
            { :id => 3, :descricao => "nao_aprovado"},
            { :id => 4, :descricao => "aguardando_desenvolvimento"},
            { :id => 5, :descricao => "em_desenvolvimento"},
            { :id => 6, :descricao => "desenvolvimento_interrompido"},
            { :id => 7, :descricao => "aguardando_homologacao"},
            { :id => 8, :descricao => "em_homologacao"},
            { :id => 9, :descricao => "homologacao_reprovada"},
            { :id => 10, :descricao => "liberado_publicacao"},
            { :id => 11, :descricao => "publicado"}]


  validates_presence_of :descricao
  validates_uniqueness_of :descricao
  validates_length_of :descricao, :maximum => 30

  #has_many :pendencia_itens
  has_many :pendencia_item_historicos
  has_many :solicitacoes
  has_many :tempo_evolucoes, class_name:'StatusTempoEvolucao'

  def self.primeira_ocorrencia_por_status(usuario_id)
    first(:joins => [:solicitacoes],:order => "status.id",
          :conditions => {"solicitacoes.usuario_responsavel_id" => usuario_id})
  end

end
