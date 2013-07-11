module LayoutHelper
 def section_tag(options={}, &block)
 	if options[:id].present?
    	content_tag :div, {:class => (options[:class] || "section-tag"),
    					   :id 	  => options[:id] } do
    		section_content(options, &block)
		end
	else		
    	content_tag :div, :class => (options[:class] || "section-tag")do 
    		section_content(options, &block)
		end
    end
  end
  def section_content(options={}, &block)
      html = []
      html << content_tag(:h3, options[:legend], :class => "title") if options[:legend].present?
      html << content_tag(:div, &block)
      html.join.html_safe
  end
end
