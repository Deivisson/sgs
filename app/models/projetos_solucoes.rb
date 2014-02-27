class ProjetosSolucoes < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :solucao
end
