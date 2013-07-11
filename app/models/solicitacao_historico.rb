# -*- encoding : utf-8 -*-
class SolicitacaoHistorico < ActiveRecord::Base

  validates_presence_of :usuario_id,:status_id,:usuario_responsavel_id

  belongs_to :solicitacao
  belongs_to :usuario
  belongs_to :usuario_responsavel,
             :class_name    => "Usuario",
             :foreign_key   => "usuario_responsavel_id"

  belongs_to :status

  #callbacks 
  after_create :controla_status_da_solicitacao,:assinala_como_nao_lido
  def after_destroy
    controla_status_da_solicitacao(true)
  end
  
  
private 

  #Método responsável por atualizar o status atual da solicitação.
  #@deletando => Se parâmetro = true, é porque esta excluindo 
  #um histórico. Com isto, recuperará o status e responsável do
  #último histórico e atualizará a solicitação em questão.
  def controla_status_da_solicitacao(deletando = false)
    @solicitacao = solicitacao
    if deletando
      #Recupera o ultimo histórico da solicitacao.
      @solicitacao_historico = SolicitacaoHistorico.last(
        :conditions => {:solicitacao_id =>@solicitacao.id}
      )

      #Atualiza o Status da Solicitacao
      @solicitacao.status = @solicitacao_historico.status
      @solicitacao.usuario_responsavel = @solicitacao_historico.usuario_responsavel
    else
      #Recupera os dados do ultimo histórico da solicitacao cadastrada e atualiza a Solicitacao
      @solicitacao.status = status
      @solicitacao.usuario_responsavel = usuario_responsavel
    end
    @solicitacao.save
  end

  #Assinala solicitacao como nao lida, com intuito de chamar atencao do responsavel
  def assinala_como_nao_lido
    if usuario_id != usuario_responsavel_id 
       solicitacao.update_attributes!(:nao_lido => true)
    end
  end
end


