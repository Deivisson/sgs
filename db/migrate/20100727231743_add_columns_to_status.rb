class AddColumnsToStatus < ActiveRecord::Migration
  def self.up
    add_column :status, :padrao, :boolean,:nil => false, :default => false
    add_column :status, :encerramento,:boolean,:nil => false, :default => false

    #execute(update_registro_padrao)
    #execute(update_status_encerramento)
  end

  def self.down
    remove_column :status, :padrao
    remove_column :status, :encerramento
  end

  def self.update_registro_padrao
    <<-END_OF_DATA
     update status set padrao = 1;
     END_OF_DATA
  end

  #atualiza status padrao "Publicado" para um status de encerramento
  def self.update_status_encerramento
    <<-END_OF_DATA
     update status set encerramento = 1 where id = 11;
     END_OF_DATA
  end

end
