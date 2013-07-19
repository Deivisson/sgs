# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def carrega_empresa
    return Empresa.first
  end

  def carrega_ufs()
    ["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS","MG","PA","PB",
     "PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"  ]
  end


  def load_status
    status_list = Solicitacao.all(:group => 'status_id,status.descricao,nao_lido',
                                  :conditions => ['usuario_responsavel_id = ? and status.encerramento = ?',current_usuario,false],
                                  :select => 'count(status_id) as qtde,status.descricao, nao_lido,status_id',
                                  :joins => :status)
    result = Array.new
    for status in status_list
      if  (status != nil)
        item = ["#{status.descricao[0..15]}",status.qtde,status.status_id,status.nao_lido]
      else
        item = ["#{status.descricao[0..15]}",0,status.status_id,false]
      end
      result << item
    end
    return result
  end

  def get_allow_status (solicitacao)
    ret = StatusUsuarioCargo.find(:first,
      :conditions => {:status_id        => solicitacao.status_id,
                      :usuario_cargo_id => current_usuario.usuario_cargo.id})
    return [] if ret.nil?
    return eval("[#{ret.status_fluxo}]")
  end

  #Volta a pagina anterior
  def link_voltar(titulo = 'Voltar' )
    "<li class='links'><a href='javascript:history.go(-1)' class='back'>#{titulo}</a></li>".html_safe
  end

  def image_link
    {:show => '/assets/icons/16/show.png',
     :edit => '/assets/icons/16/edit.png',
     :del => '/assets/icons/16/delete.png',
     :new => '/assets/icons/16/new.png',
     :anexo => '/assets/icons/16/anexo.png',
     :pdf => '/assets/icons/16/pdf.png',
     :printer24 => '/assets/icons/24/printer.png',
     :add24 => '/assets/icons/24/add.png',
     :remove24 => '/assets/icons/24/remove.png'
    }
  end

  def formata_data(date, format = :default)
    return "" if date.nil?
    I18n.localize(date, :format => format)
  end

  def formata_hora(hora)
    return "" if hora.nil? 
    hora.to_s(:time)
  end

  def show_tiny_mce
    content_for(:tiny_mce) {tiny_mce}   
  end

  def tiny_mce 
    mce = <<-TINY
      <script  type ="text/javascript">
        tinyMCE.init({
        mode : "textareas",
        theme: "advanced",
        plugins: "print,fullscreen",
        // Theme options
        theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,fontsizeselect,forecolor,backcolor,|,outdent,indent,|,bullist,numlist,|,undo,redo,|,print,fullscreen",
        theme_advanced_buttons2 : "",
        theme_advanced_buttons3 : "",
        theme_advanced_buttons4 : "",
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        tab_focus: ':prev,:next'

      });
      </script>
    TINY
    mce.html_safe
  end

  def permite_estimar(solicitacao)
    if solicitacao.etapa_desenvolvimento? 
      return current_usuario.estima_desenvolvimento? 
    elsif solicitacao.etapa_instalacao? 
      return current_usuario.estima_instalacao?
    end
  end

end
