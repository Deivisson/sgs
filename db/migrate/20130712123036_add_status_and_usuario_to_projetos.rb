class AddStatusAndUsuarioToProjetos < ActiveRecord::Migration
  def change
    add_column :projetos, :status, :integer, :null => false
    add_column :projetos, :usuario_id, :integer, :null => false
	  
	  add_index :projetos, :usuario_id
		add_foreign_key :projetos, :usuarios, :name => 'fk_projetos_usuarios'
  end
end
