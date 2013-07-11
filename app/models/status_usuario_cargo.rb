# -*- encoding : utf-8 -*-
class StatusUsuarioCargo < ActiveRecord::Base
  def self.atualiza_status_fluxo(cargo_id,status_id,status_flow)
    begin
      find_by_sql("update status_usuario_cargos set status_fluxo = '#{status_flow}' where status_id = #{status_id} and usuario_cargo_id = #{cargo_id}")  
    rescue
    end
  end
end
