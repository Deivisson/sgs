module ButtonsHelper
  def submit_button(f, options={})
    f.action :submit,
             :label => options[:label] || "Salvar",
             :button_html => { :class => options[:class] || "submit-button",
                               :disable_with => "Aguarde..." }
  end

  def link_to_cancel(url,html_options={})
    content_tag(:li) do
      html_options.reverse_merge!(:class => "cancel-link")
      title = "Cancelar"
      link_to(url, html_options) do
        title
      end.html_safe
    end
  end

  def link_to_edit(url,html_options={})
    content_tag(:li) do
      html_options.reverse_merge!(:class => "edit-link")
      title = "Editar"
      link_to(url, html_options) do
        title
      end.html_safe
    end
  end  

  def link_to_list(url,html_options={})
    content_tag(:li) do
      html_options.reverse_merge!(:class => "back_to_list")
      title = "Voltar Lista"
      link_to(url, html_options) do
        title
      end.html_safe
    end
  end

  def link_to_back(url="javascript: window.history.go(-1)",html_options={})
    html_options.reverse_merge!(:class => "back-to-list")
    title = "Voltar"
    link_to(url, html_options) do
      title
    end
  end

end
