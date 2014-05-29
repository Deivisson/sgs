class CheckListItem < ActiveRecord::Base
	validates :descricao, presence:true, length: {maximum:50}, uniqueness:true
  attr_accessible :descricao
  has_and_belongs_to_many :solucoes

  def number
  	self.id.to_s.rjust(6,'0')
  end
end
