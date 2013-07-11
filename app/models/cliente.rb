
# -*- encoding : utf-8 -*-
include ActionView::Helpers::NumberHelper 
class Cliente < ActiveRecord::Base

  validates_presence_of :nome
  validates_uniqueness_of :nome

  validates_length_of :nome, :maximum => 50,:allow_blank => false
  validates_length_of :endereco, :maximum => 50, :allow_blank => true
  validates_length_of :complemento, :maximum => 30, :allow_blank => true
  validates_length_of :bairro, :maximum => 30, :allow_blank => true
  validates_length_of :cidade, :maximum => 50, :allow_blank => true
  validates_length_of :uf,:in => 2..2, :allow_blank => true
  validates_length_of :cep,:in => 8..8, :allow_blank => true
  validates_length_of :telefone, :maximum => 11, :allow_blank => true
  validates_length_of :fax, :maximum => 11, :allow_blank => true

  validates :valor_deslocamento, :presence => true,
            :numericality => {:greater_than => 0} 

  validates :valor_hora_visita, :presence => true,
            :numericality => {:greater_than => 0}  

  validates :minutos_bonus, :presence => true #minutos de bonus do cliente

  has_many :cliente_contatos
  has_many :pendencias
  has_and_belongs_to_many :solucoes
  has_many :ordem_servicos

  attr_accessor :horas_bonus

  scope :to_select, :select => 'nome,id', :order => :nome
  
  scope :to_select_by_usuario, lambda {|usuario_id| { 
    :select => 'distinct clientes.id,clientes.nome',
    :joins =>[:solucoes =>:usuarios],
    :conditions => ['usuarios.id = ?',usuario_id]
  }}

  before_save :calcula_minutos_de_bonus

  def horas_bonus
    return "" unless minutos_bonus > 0
    minutos_bonus.divmod(60).collect{|m| m.to_s.rjust(2,'0')}.join(":")
  end

  def debita_minutos_bonus(minutos)
    self.minutos_bonus  -= minutos
    self.save
  end

  def credita_minutos_bonus(minutos)
    self.minutos_bonus  += minutos
    self.save
  end

  # def valor_hora_visita
  #   return 0 unless valor_minuto_visita > 0 
  #   number_to_currency ((valor_minuto_visita.to_f * 60).round(2))
  # end

private 

  def calcula_minutos_de_bonus
    if @horas_bonus.present?
      h = @horas_bonus.split(":")#retorna array com horas e minutos
      minutos  = h.first.to_i * 60  
      minutos += h.second.to_i
      self.minutos_bonus = minutos      
    else
      self.minutos_bonus
    end

  end
  
  # def calcula_valor_minuto_visita
  #   self.valor_minuto_visita =
  #   if  @valor_hora_visita.present?
  #      @valor_hora_visita.to_f / 60
  #   else
  #      0 
  #   end
  # end

  #def self.to_select_by_usuario(usuario_id) 
  #  not_includes = Solucao.all(:select => 'solucoes.id',:conditions => ['id not in(SELECT DISTINCT solucao_id FROM solucoes_usuarios WHERE usuario_id = ?)',usuario_id])
  #  ids = ''
  #  not_includes.each do |i|
  #    ids += ',' if not ids.empty?
  #    ids += i.id.to_s
  #  end
  #  clientes = Cliente.all(:select =>'distinct clientes.id,clientes.nome', :joins => :solucoes,:conditions => "not solucoes.id in (#{ids})")
  #end

end
