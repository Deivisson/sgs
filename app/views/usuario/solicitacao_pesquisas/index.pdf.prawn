@empresa = Empresa.find(1)
Prawn::Document.generate("find.pdf",:page_layout => :landscape) do |pdf|

    #logo = @empresa.logo.to_file.path
     
    #logo = "/home/deivisson/Projects/sgsoft/public/images/empresas/logos/1/original/SIEMATECLOGO.JPG"
    #pdf.image logo, :width => 70,:position => :left,:vposition => :top
    pdf.move_up(23)
    pdf.text "Listagem de Solicitações",:align => :center
    pdf.text Time.now.strftime("Emitido em %d/%m/%Y"),:size => 7,:align => :right

    pdf.move_down(10)

    items = @solicitacoes.map do |item|
        campos = []
        @camposTitle = []
        for campo in @campos
            campos <<  item.read_attribute(campo[1]) 
            @camposTitle <<  campo[0] 
        end
        campos
    end

    pdf.table items
        #,
         #:font_size => 10,   
         #:horizontal_padding => 2,
         #:vertical_padding => 2,
         #:border_style => :underline_header,
         #:headers => @camposTitle,
         #:overflow => :truncate,
         #:column_width => [10],
         #:row_colors => ["FFFFFF","DDDDDD"]

    #pdf.number_pages "<page> de <total>",[pdf.bounds.right-50,pdf.bounds.bottom-10]
    pdf.move_down(10)
    pdf.text "SGS - #{@empresa.razao}",:size => 8
    pdf.move_up(10)
  
end
pdf.text "Total de Solicitações: #{@solicitacoes.size}",:size => 8,:align => :right
