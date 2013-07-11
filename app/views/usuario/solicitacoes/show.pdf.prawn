Prawn::Document.generate("index.pdf",:page_layout => :landscape) do |pdf|
    
    logo = @empresa.logo.to_file.path
    pdf.image logo, :width => 70,:position => :left,:vposition => :top
    pdf.move_up(23)
    pdf.text "Título: #{@solicitacao.titulo}",:align => :center,:style => :bold
    pdf.text Time.now.strftime("Emitido em %d/%m/%Y"),:size => 7,:align => :right
   
    pdf.move_down(10)
    pdf.text "Cliente: ",:size => 10,:style => :bold
    pdf.text "Solicitante: ",:size => 10,:style => :bold
    pdf.text "Solucao: ",:size => 10,:style => :bold
    pdf.text "Sub Módulo: ",:size => 10,:style => :bold
    pdf.text "Prioridade: ",:size => 10,:style => :bold
    pdf.text "Tipo: ",:size => 10,:style => :bold
    pdf.text "Status: ",:size => 10,:style => :bold
    pdf.text "Cadastrado em: ",:size => 10,:style => :bold
    pdf.text "Previsão Liberação: ",:size => 10,:style => :bold
    pdf.text "Versão Liberação: ",:size => 10,:style => :bold
    pdf.text "Detalhe: ",:size => 10,:style => :bold
    @detalhe =h @solicitacao.detalhe
    pdf.text @detalhe 


    pdf.text @solicitacao.detalhe

    pdf.move_down(10)
end



