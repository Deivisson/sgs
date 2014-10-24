class CreatePermissoesUsuarioCargos < ActiveRecord::Migration
  def change
    create_table :permissoes_usuario_cargos, id:false do |t|
      t.references :usuario_cargo
      t.references :permissao
      t.timestamps
    end
    add_index :permissoes_usuario_cargos, :usuario_cargo_id
    add_index :permissoes_usuario_cargos, :permissao_id
  end
end
