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
    status_list = Solicitacao.all(:group => 'status_id,status.descricao',
                                  :conditions => ['usuario_responsavel_id = ? and status.encerramento = ?',current_usuario,false],
                                  :select => 'count(status_id) as qtde,status.descricao, nao_lido,status_id',
                                  :joins => :status)
    result = Array.new
    for status in status_list
      if  (status != nil)
        item = ["#{status.descricao.truncate(18)}",status.qtde,status.status_id,status.nao_lido]
      else
        item = ["#{status.descricao.truncate(18)}",0,status.status_id,false]
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
  def link_voltar(titulo = 'Voltar',only_link=false )
    link = ""
    if only_link
      link = "<a href='javascript:history.go(-1)'>#{titulo}</a>"
    else
      link = "<li class='links'><a href='javascript:history.go(-1)' class='back'>#{titulo}</a></li>"
    end
    link.html_safe
  end

  def image_link
    {:show => '/assets/icons/16/show.png',
     :edit => '/assets/icons/16/edit.png',
     :del => '/assets/icons/16/delete.png',
     :new => '/assets/icons/16/new.png',
     :anexo => '/assets/icons/16/anexo.png',
     :pdf => '/assets/icons/16/pdf.png',
     :schedule => '/assets/icons/16/schedule.png',
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
      <script type ="text/javascript">
         tinymce.init({
            selector: "textarea",
            menubar: false,
            plugins: [
                "fullscreen","textcolor","print preview"
            ],
            toolbar1: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | print preview media | forecolor backcolor| fullscreen"
            });
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

  def main_menu(path,options={})
    html = []
    css_class = session[:current_menu] == options[:target] ? "current" : ""
    html << content_tag(:li,class:css_class,title:options[:title]) do
      inner_html = []
      inner_html << link_to(image_tag("/assets/icons/32/#{options[:icon_name]}.png"),path)
      inner_html.join.html_safe
    end
    html.join.html_safe
  end

  def possui_permissao?(chave)
    current_usuario.send("permission_#{chave.to_s}?")
  end

  def permissao_usuario!(chave)
    redirect_to usuario_permission_index_path unless possui_permissao?(chave)
  end
end
