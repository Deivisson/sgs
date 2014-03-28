# -*- encoding : utf-8 -*-
include DataHoraHelper
include SolicitacoesHelper
class Solicitacao < ActiveRecord::Base.extend Search

  COMPLEXIDADE_BAIXA = 1
  COMPLEXIDADE_MEDIA = 2
  COMPLEXIDADE_ALTA = 3

  has_attached_file :anexo, 
                    :style => {:medium => "250x250>",:thumb => "100x100>"},
          					:path => ":rails_root/public/anexos/:class/:attachment/:id/:style/:basename.:extension",
          					:url => "/anexos/:class/:attachment/:id/:style/:basename.:extension"

  validates :cliente_id, presence:true
  validates :usuario_cadastrante_id, presence:true
  validates_presence_of :status_id,:prioridade_id, :solucao_sub_modulo_id
  validates_presence_of :cliente_contato_id,:tipo_pendencia_id,:titulo,:detalhe
  validates_presence_of :usuario_responsavel_id
  validate :validate_presence_of_detalhe_ultimo_historico
  #validate :validate_presence_of_data_prevista_liberacao
  #validate :validate_presence_of_versao_liberacao
  validates_length_of :titulo, :maximum => 60
  validates_length_of :versao_liberacao, :maximum => 15, :allow_blank => true

  validates :previsao_duracao_horas, 
            :presence => true, 
            :if       => Proc.new {|s| 
              ([Status::AG_DESENV, Status::EM_DESENV].include? s.status_id) && 
              (s.previsao_duracao_minutos.nil? || s.previsao_duracao_minutos == 0) &&
              s.projeto_id.present?
            } 

  validates :nivel_complexidade, 
            :presence   => true, 
            :if         => Proc.new {|s| 
              ([Status::AG_DESENV, Status::EM_DESENV].include? s.status_id) && 
              s.nivel_complexidade.nil? && s.projeto_id.present?
            } 

  validates :valor_cobranca, 
            :presence     => true, 
            :numericality => {:greater_than_or_equal_to => 1},
            :if           => Proc.new {|s|
              ([Status::AG_DESENV, Status::EM_DESENV].include? s.status_id) && 
              s.gera_cobranca == true && s.projeto_id.present?
            } 

  validates :peso, :numericality => {only_integer:true},
            :if => Proc.new{|s| s.projeto_id.present?}

  belongs_to :cliente
  belongs_to :projeto
  belongs_to :status
  belongs_to :prioridade
  belongs_to :solucao_sub_modulo
  belongs_to :cliente_contato
  belongs_to :tipo_pendencia
  belongs_to :usuario_responsavel,
             :class_name => "Usuario",
             :foreign_key => "usuario_responsavel_id"
  
  belongs_to :usuario_cadastrante,
             :class_name => "Usuario",
             :foreign_key => "usuario_cadastrante_id"

  belongs_to :ordem_servico
  belongs_to :etapa
  has_many :historicos, class_name:"SolicitacaoHistorico"
  has_many :alteracoes, class_name:"SolicitacaoLogAlteracao"
  has_one :tarefa

  attr_writer :solucao_id,:modulo_id
  attr_accessor :previsao_duracao_horas,:usuario_editor


  Status::ITENS.each do |s|
    define_method "#{s[:descricao]}?" do 
      self.status_id == s[:id] 
    end
  end

  def controle
    self.id.to_s.rjust(6,'0')
  end

  def etapa_desenvolvimento?
    etapa_id == Etapa::DESENVOLVIMENTO
  end

  def etapa_instalacao?
    etapa_id == Etapa::INSTALACAO
  end


  def titulo_formatado
    "#{self.id.to_s.rjust(6,'0')} - #{self.titulo}"
  end

  def associador
    self.projeto
  end

  def solucao_id
    @solucao_id = solucao_sub_modulo.nil? ? 0 : 
                  solucao_sub_modulo.solucao_modulo.solucao_id
  end

  def modulo_id
    @modulo_id = solucao_sub_modulo.nil? ? 0 : 
                 solucao_sub_modulo.solucao_modulo_id
  end

  def gera_cobranca?
    self.gera_cobranca
  end

  def previsao_de_duracao
    minutos_em_horas(self.previsao_duracao_minutos)
  end

  def pendente_previsao?
    self.previsao_duracao_minutos == 0 ||
    self.nivel_complexidade.nil?       ||
    self.gera_cobranca.nil?
  end

  def permite_alterar_cliente?
    !(self.projeto_id.present?)
  end

  def complexidade
    options_for_nivel_complexidade.each{|k,v| return k if v==self.nivel_complexidade}
  end
  #callbacks
  before_validation :attribui_minutos_previsao_duracao
  after_create :inserir_historico_padrao
  after_update :registrar_log_alteracao

  def before_destroy
    #Não permite excluir se ja foi encerrado
    if !Solicitacao.all(
        :joins      => :status,
        :conditions => ['solicitacoes.id = ? and status.encerramento = ?',id,1]
      ).empty?
      errors.add_to_base('Exclusão não permitida. Solicitação já encerrada..')
      return false
    #Não permite excluir se existir histórico cadastrado por mais de uma usuário
    elsif SolicitacaoHistorico.all(:group => :usuario_id,:conditions => ['solicitacao_id = ?',id]).count > 1
      errors.add_to_base('Exclusão não permitida. Existem históricos de 
                          movimentações realizadas por mais de um usuário.')
      return false
    end
    true
  end
  # after_destroy :delete_atendimento_interno


  #named_scopes
  def self.tarefas_do_usuario_por_status(filtro, page, per_page)
      Solicitacao.all(
              :select => "solicitacoes.*,clientes.nome as cliente_nome,
                          solucao_sub_modulos.descricao as sub_modulo,
                          prioridades.descricao as prioridade_descricao,
                          tipo_pendencias.descricao as tipo_descricao,status.encerramento",
              :joins => [{:cliente_contato => [:cliente]},
                        {:solucao_sub_modulo => [:solucao_modulo => [:solucao]]},
                        :status,:prioridade,:tipo_pendencia],
              :conditions => filtro,
              :order => 'solicitacoes.created_at desc'
              #{:status_id => status_id,:usuario_responsavel_id => usuario_id}
     )
  end

  # scope :solicitacoes_por_atendimento, lambda {|atendimento_id|{
  #             :select => "solicitacoes.id,solicitacoes.titulo,solucao_sub_modulos.descricao as sub_modulo,
  #                         tipo_pendencias.descricao as tipo_descricao,status.descricao as status_descricao,
  #                         cliente_contatos.nome as nome_contato,solicitacoes.data_previsao_liberacao",
  #             :joins => [:atendimento,:cliente_contato,:solucao_sub_modulo,:status,:tipo_pendencia],
  #             :conditions => {:atendimento_id => atendimento_id}

  # }}

private

  #After_Create
  #Insercao de historico padrao para a solicitacao, no qual iniciara com status de Aberto.
  def inserir_historico_padrao
    historicos  << SolicitacaoHistorico.new(
        :usuario => self.usuario_cadastrante,:usuario_responsavel => usuario_responsavel,
        :status  => status,:detalhe => 'Solicitação cadastrada'
    )
  end

  #After_Destroy
  #Caso a solicitacao estiver vinculada a um atendimento que é interno,
  #ou seja, não possui um atendimento formal. Irá deletar o mesmo
  # def delete_atendimento_interno
  #   Atendimento.destroy(atendimento.id) if atendimento.interno
  # end

  #Validacoes
  def validate_presence_of_detalhe_ultimo_historico
    if liberado_publicacao? && self.detalhe_ultimo_historico.empty?
      errors.add("solicitacao","can't be blank 2")
    end
  end

  # def validate_presence_of_data_prevista_liberacao
  #   if (aguardando_desenvolvimento? || desenvolvimento_interrompido? || 
  #       homologacao_reprovada?) && self.data_previsao_liberacao.empty?
  #     errors.add("solicitacao","É necessário informar a previsão de Liberação") 
  #   end
  # end

  # def validate_presence_of_versao_liberacao
  #   if (liberado_publicacao? or publicado?) && self.versao_liberacao.empty?
  #     errors.add("solicitacao","É necessário informar a versão da Liberação") 
  #   end
  # end

  def attribui_minutos_previsao_duracao
    return if self.previsao_duracao_horas.nil? || self.previsao_duracao_horas.empty?
    self.previsao_duracao_minutos = total_minutos(self.previsao_duracao_horas)
  end

  def registrar_log_alteracao
    return unless self.changed?
    log = self.alteracoes.build(usuario_id:self.usuario_editor)
    self.changes.each do |k,v|
      unless ['created_at','updated_at','usuario_responsavel_id'].include?(k.to_s)
        valor_de, valor_para = recupera_alteracoes(k,v.first.to_s,v.second.to_s)
        _attributes = {campo:Solicitacao.human_attribute_name(k), 
                       velho_conteudo:valor_de,
                       novo_conteudo: valor_para}
        log.itens << SolicitacaoLogAlteracaoItem.new(_attributes)
      end
    end
    log.save
  end


  def recupera_alteracoes(campo, valor_atual, valor_alterado)
    if campo =~ /(.+)_id$/
        model_origem  = $1.classify.constantize.find(valor_atual)
        model_destino = $1.classify.constantize.find(valor_alterado)
 
         unless (model_origem.nil? && model_destino.nil?)
          if model_origem.respond_to?(:descricao)
            valor_atual     = model_origem.descricao
            valor_alterado  = model_destino.descricao
          elsif model_origem.respond_to?(:nome)
            valor_atual     = model_origem.nome
            valor_alterado  = model_destino.nome
          end
        end
    end
    return [valor_atual, valor_alterado]
  end

end
