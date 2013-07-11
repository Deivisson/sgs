class ChangeTableNameFromProjetosToSolucoes < ActiveRecord::Migration
	def change
		rename_table :projetos, :solucoes
	end
end
