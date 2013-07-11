class AddAttachmentsAnexoToSolicitacoes < ActiveRecord::Migration
  def self.up
    add_column :solicitacoes, :anexo_file_name, :string
    add_column :solicitacoes, :anexo_content_type, :string
    add_column :solicitacoes, :anexo_file_size, :integer
    add_column :solicitacoes, :anexo_updated_at, :datetime
  end

  def self.down
    remove_column :solicitacoes, :anexo_file_name
    remove_column :solicitacoes, :anexo_content_type
    remove_column :solicitacoes, :anexo_file_size
    remove_column :solicitacoes, :anexo_updated_at
  end
end
