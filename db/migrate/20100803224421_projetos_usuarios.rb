class ProjetosUsuarios < ActiveRecord::Migration
  def self.up
    create_table :projetos_usuarios, :id => false do |t|
      t.integer :projeto_id, :null => false
      t.integer :usuario_id, :null => false
      t.timestamps
    end

    add_index :projetos_usuarios, :projeto_id
    add_index :projetos_usuarios, :usuario_id
    add_foreign_key :projetos_usuarios, :usuarios, :dependent => :delete
    add_foreign_key :projetos_usuarios, :projetos,:name => "fk_projetos_usuarios_projetos"
  end

  def self.down
    drop_table :projetos_usuarios
  end

end
