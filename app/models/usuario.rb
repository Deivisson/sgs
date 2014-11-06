# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :encryptable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :photo

  validates_presence_of :nome, :usuario_cargo_id, :email
  validates_uniqueness_of :nome,:email

  validates_length_of :nome, :maximum => 50
  validates_length_of :email, :maximum => 50
  validates_length_of :celular, :maximum => 11, :allow_blank => true

  validates_format_of :email,:with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
					  :message => 'e-mail inválido'

  belongs_to :usuario_cargo
  # has_many :pendencias
  # has_many :pendencia_itens
  # has_many :pendencia_item_historicos
  has_many :solicitacao_historicos, foreign_key:"usuario_responsavel_id"
  has_and_belongs_to_many :solucoes
  has_one :usuario_config
  has_many :ordem_servicos    
  has_many :projetos
  has_many :solicitacao_log_alteracoes
  has_many :programacao_treinamentos, class_name: 'ProjetoProgramacaoTreinamento'
  has_many :tarefas
  has_many :compromissos

  scope :to_select,:select => 'nome,id', :order => :nome
  scope :to_select_by_status, lambda {|status_id|{
      :select => 'usuarios.id,usuarios.nome',
      :joins => {:usuario_cargo => :status},
      :conditions => ['status.id = ?',status_id],
      :order => :nome
  }}

  attr_accessor :usuario_substituto

  before_destroy :update_referencias_usuario
  after_create :adiciona_usuario_config
  
  has_attached_file :photo,
                      :styles => { :tiny => ["32x32>",:png], :medium => ["176x190>",:png]},
                      :path => ":rails_root/public/images/uploads/:class/:attachment/:id/:style/:basename.:extension",
                      :url => "/images/uploads/:class/:attachment/:id/:style/:basename.:extension",
                      :default_url => "/assets/foto/foto.png"

  Permissao.all.each do |permissao|
    define_method("permission_#{permissao.chave}?".to_sym) do
      self.minhas_permissoes.include?(permissao.id)
    end 
  end

  def minhas_permissoes
    @minhas_permissoes ||= self.usuario_cargo.permissao_ids
  end

  def estima_desenvolvimento?
    self.usuario_cargo.estima_desenvolvimento
  end

  def estima_instalacao?
    self.usuario_cargo.estima_instalacao
  end

  def tarefas_nao_finalizadas
    tarefas = self.tarefas.includes(:solicitacao => :prioridade)
    tarefas = tarefas.joins(:solicitacao => :status).where("status.encerramento = ? ",false)
  end
  
private
  def update_referencias_usuario
    #ATENÇÂO. Foi aconselhado ao Cléber não realizar esta operação, pois este método
    #irá substitui toda a movimentação de um usuário para um outro e em seguida excluirá o mesmo.
    # Observação da Análise feita: Excluir um usuário do sistema pode ter um
    # impacto negativo gerando inconsistência históricas e de integridade da
    # ferramenta. Para exclusão do usuário, terei que percorrer todas as
    # tabelas citadas ao lado atualizando os campos de usuários para o usuário
    # que foi escolhido para subistituir o que esta sendo excluído. Quando
    # falo de inconsistência, digo no sentido de que em algumas situações vai
    # constar que quem cadastrou um determinado registro foi o usuário "X"
    # porque ele substituiu o usuário "Y", porém não foi. E outro fator
    # impactante é que todos os agendamentos de um usuário que futuramente
    # poderá esta ligada a uma OS, passará a estar ligado a um outro usuário
    # que não tem nada haver.
    return if self.usuario_substituto.nil?
    u_id = self.usuario_substituto.id
    Compromisso.where(usuario_cadastrante_id:self.id).update_all(usuario_cadastrante_id:u_id)
    OrdemServico.where(usuario_cadastrante_id:self.id).update_all(usuario_cadastrante_id:u_id)
    OrdemServico.where(usuario_responsavel_id:self.id).update_all(usuario_responsavel_id:u_id)
    ProjetoProgramacaoTreinamento.where(usuario_id:self.id).update_all(usuario_id:u_id)
    Projeto.where(usuario_id:self.id).update_all(usuario_id:u_id)
    SolicitacaoHistorico.where(usuario_id:self.id).update_all(usuario_id:u_id)
    SolicitacaoHistorico.where(usuario_responsavel_id:self.id).update_all(usuario_responsavel_id:u_id)
    Solicitacao.where(usuario_cadastrante_id:self.id).update_all(usuario_cadastrante_id:u_id)
    Solicitacao.where(usuario_responsavel_id:self.id).update_all(usuario_responsavel_id:u_id)    
    self.solucoes.destroy_all
    Tarefa.where(usuario_id:self.id).update_all(usuario_id:u_id)
    Atendimento.where(usuario_cadastrante_id:self.id).update_all(usuario_cadastrante_id:u_id)
    Atendimento.where(usuario_solicitante_id:self.id).update_all(usuario_solicitante_id:u_id)    
  end

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end

  def adiciona_usuario_config
    UsuarioConfig.create(:usuario_id => self.id)
  end

end
