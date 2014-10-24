class PermissoesUsuarioCargos < ActiveRecord::Base
  belongs_to :usuario_cargo
  belongs_to :permissao
end
