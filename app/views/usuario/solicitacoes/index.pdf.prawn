@empresa = Empresa.find(1)
Prawn::Document.generate("index.pdf",:page_layout => :landscape) do |pdf|

    logo = @empresa.logo.to_file.path
           
    #logo = "/home/deivisson/Projects/sgsoft/public/images/empresas/logos/1/original/SIEMATECLOGO.JPG"
    pdf.image logo, :width => 70,:position => :left,:vposition => :top
    pdf.move_up(23)
    pdf.text "Listagem de Solicitações - #{@status_description}",:align => :center
    pdf.text Time.now.strftime("Emitido em %d/%m/%Y"),:size => 7,:align => :right

    pdf.move_down(10)

    hoje = Date.parse(Time.now.strftime("%Y-%m-%d")) 
    if not @solicitacoes.empty?
        items = @solicitacoes.map do |item|
         [
            item.id.to_s.rjust(5,'0'),
            item.cliente_nome,
            item.titulo,	
            item.sub_modulo,
            item.prioridade_descricao,
            item.tipo_descricao,
            (hoje - Date.parse(item.created_at.strftime("%Y-%m-%d"))).to_i

        ]
        end

        pdf.table items,
             :font_size => 9,   
             :horizontal_padding => 2,
             :vertical_padding => 2,
             :border_style => :underline_header,
             :headers => ["Nº Solic","Cliente","Título","Sub Módulo","Prioridade","Tipo","Dias"],
             :row_colors => ["FFFFFF","e5e5e5"]
    end
    pdf.number_pages "<page> de <total>",[pdf.bounds.right-50,pdf.bounds.bottom-10]
   
end
pdf.move_down(10)
pdf.text "SGS - #{@empresa.razao}",:size => 8
pdf.move_up(10)
pdf.text "Total de Solicitações: #{@solicitacoes.size}",:size => 8,:align => :right
