class CreateConfiguracoes < ActiveRecord::Migration
  def self.up
    create_table :configuracoes do |t|
      t.integer :atendimento_padrao_id

      t.timestamps
    end
        
    add_foreign_key(:configuracoes,:atendimentos,:column => "atendimento_padrao_id",:name => "fk_atendimento_configuracao")
    
    execute(insert_default)
  end
    
  def self.insert_default
    <<-END_OF_DATA
    insert into configuracoes (id,created_at, updated_at)  values
    (1, '20120101','20120101')
    END_OF_DATA
  end

  def self.down
    drop_table :configuracoes
  end
end
