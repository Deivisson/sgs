# -*- encoding : utf-8 -*-
class Empresa < ActiveRecord::Base
	validates_presence_of :razao,:fantasia,:cnpj
	has_attached_file :logo, :style => {:medium => "250x250>",:thumb => "100x100>"},
					:path => ":rails_root/public/images/:class/:attachment/:id/:style/:basename.:extension",
					:url => "/images/:class/:attachment/:id/:style/:basename.:extension"
									
					
	def endereco_completo
		[endereco,complemento,cidade,"-",uf].join(", ")
	end
end
