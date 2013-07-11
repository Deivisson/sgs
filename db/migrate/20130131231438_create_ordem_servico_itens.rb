class CreateOrdemServicoItens < ActiveRecord::Migration
  def change
    create_table :ordem_servico_itens do |t|
      t.references :ordem_servico, :null => false
      t.references :projeto_sub_modulo, :null => false
      t.references :tipo_avaliacao, :null => false
      t.references :situacao, :null => false
      t.string :usuarios, :null => false, :limit => 100
      t.string :setor, :null => false, :limit => 30

      t.timestamps
    end
    add_index :ordem_servico_itens, :ordem_servico_id
    add_index :ordem_servico_itens, :projeto_sub_modulo_id
    add_index :ordem_servico_itens, :tipo_avaliacao_id
    add_index :ordem_servico_itens, :situacao_id

    add_foreign_key :ordem_servico_itens, :ordem_servicos, :name => "fk_ordem_servico_itens_ordem_servico"
    add_foreign_key :ordem_servico_itens, :projeto_sub_modulos, :name => "fk_ordem_servico_itens_sub_modulo"
    add_foreign_key :ordem_servico_itens, :tipo_avaliacoes, :name => "fk_ordem_servico_itens_tipo_avaliacoes"
    add_foreign_key :ordem_servico_itens, :situacoes, :name => "fk_ordem_servico_itens_situacoes"
    
  end
end
