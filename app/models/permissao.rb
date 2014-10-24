class Permissao < ActiveRecord::Base
  validates :descricao, presence:true
  validates :chave, presence:true, uniqueness:true
  
  has_and_belongs_to_many :usuario_cargos

  def self.salvar_permissao(params)
    permissao = Permissao.where(chave:params["chave"]).first
    if permissao.nil?
      permissao = Permissao.create!(params)
    else
      permissao.update_attributes!(params)
    end
    permissao
  end

end
