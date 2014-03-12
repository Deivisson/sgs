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
  has_many :solicitacao_historicos, :foreign_key   => "usuario_responsavel_id"
  has_and_belongs_to_many :solucoes
  has_one :usuario_config
  has_many :ordem_servicos    
  has_many :projetos
  has_many :solicitacao_log_alteracoes
  has_many  :programacao_treinamentos, class_name: 'ProjetoProgramacaoTreinamento'
    
  scope :to_select,:select => 'nome,id', :order => :nome
  scope :to_select_by_status, lambda {|status_id|{
      :select => 'usuarios.id,usuarios.nome',
      :joins => {:usuario_cargo => :status},
      :conditions => ['status.id = ?',status_id],
      :order => :nome
  }}

  before_destroy :validate_destroy
  after_create :adiciona_usuario_config
  
  has_attached_file :photo,
                      :styles => { :tiny => ["32x32>",:png], :medium => ["176x190>",:png]},
                      :path => ":rails_root/public/images/uploads/:class/:attachment/:id/:style/:basename.:extension",
                      :url => "/images/uploads/:class/:attachment/:id/:style/:basename.:extension",
                      :default_url => "/assets/foto/foto.png"

  def estima_desenvolvimento?
    self.usuario_cargo.estima_desenvolvimento
  end

  def estima_instalacao?
    self.usuario_cargo.estima_instalacao
  end

private
  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end

  def adiciona_usuario_config
    UsuarioConfig.create(:usuario_id => self.id)
  end

end
