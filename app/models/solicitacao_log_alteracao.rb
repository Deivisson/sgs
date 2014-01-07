# -*- encoding : utf-8 -*-
class SolicitacaoLogAlteracao  < ActiveRecord::Base
	validates :usuario_id, presence:true
	validates :solicitacao_id, presence:true
	belongs_to :solicitacao
	has_many :itens, class_name:'SolicitacaoLogAlteracaoItem'
	belongs_to :usuario
end
