# -*- encoding : utf-8 -*-
class UsuarioCargo < ActiveRecord::Base
    
  validates_uniqueness_of :descricao
  validates_length_of :descricao,:maximum => 30

  has_many :usuarios
  has_and_belongs_to_many :status

  has_and_belongs_to_many :permissoes


  def self.carrega_status_permitidos(cargo_id,status_id)
    status_usuario_cargos = StatusUsuarioCargo.all(:conditions => {:usuario_cargo_id => cargo_id, :status_id => status_id}).first
    status_usuario_cargos.status_fluxo if not status_usuario_cargos.nil? and not status_usuario_cargos.status_fluxo.nil?
  end

end
