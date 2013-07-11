# -*- encoding : utf-8 -*-
class SolicitacaoObserver < ActiveRecord::Observer
	def after_create(model)
		puts "DDDD"
	end
	def after_find(model)
		
	end
end
