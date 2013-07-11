# -*- encoding : utf-8 -*-
class OrdemServicoPdf < Prawn::Document
#http://blog.idyllic-software.com/blog/bid/204082/Creating-PDF-using-Prawn-in-Ruby-on-Rails
#http://stackoverflow.com/questions/12553755/how-to-create-lists-in-a-pdf-using-prawn-from-html-ul-and-ol-html-tags
#https://github.com/mileszs/wicked_pdf
  def initialize(ordem_servico, view)
    super()
    @ordem_servico = ordem_servico
    @empresa = Empresa.first
    cabecalho
    corpo_ordem_servico
    modulos_treinados
    assinaturas
    rodape
  end

  def cabecalho
    logo	
	  empresa_detalhes
    move_down 20
    stroke {horizontal_rule}
    dash(1.25, :space => 1.25, :phase => 0)
  end

  def logo
    logopath =  "/home/deivisson/Projects/ruby/sgsoft/public/images/empresas/logos/1/original/sie.png" 
    image logopath, :width => 100, :height => 50
  end

  def empresa_detalhes
  	move_up 30
  	text @empresa.razao , :align => :right
  	move_down 2
  	text "Departamento de Suporte a Sistema e Treinamentos", :align => :right, :size => 9
    
    contato = ""
    contato  = "Fone: #{@empresa.telefone} - " if @empresa.telefone.present?
    contato += @empresa.email_suporte || ""
    text contato, :align => :right, :size => 9
  end

  def corpo_ordem_servico
    move_down 15

    font_size 15
    text "Ordem Serviço", :align => :center
    move_up 15
    text "Nº: #{@ordem_servico.id.to_s.rjust(6,'0')}", :align => :right

    font_size 10
    move_down 30
   

    data = [[negritar("Cliente"),":",@ordem_servico.cliente.nome],
            [negritar("Solicitante"),":",@ordem_servico.solicitante.nome,"", negritar("Local Execução"), ":",@ordem_servico.local_execucao],
            [negritar("Tipo O.S."),":",@ordem_servico.tipo_os_descricao,"",negritar("Data"),":", @ordem_servico.data_execucao_formatada]] 
    table(data,:column_widths => {2 => 240},:cell_style => {:border_width => 0,:inline_format => true })

    move_down 15
    stroke {horizontal_rule}
    move_down 15
    
    data = [[negritar("Técnico Responsável"),":",@ordem_servico.responsavel.nome],
            [negritar("Hora Início"), ":",@ordem_servico.hora_inicio_formatada,"", negritar("Intervalo"), ":",@ordem_servico.tempo_intervalo_formatado],
            [negritar("Hora Término"),":",@ordem_servico.hora_fim_formatada,"",negritar("Horas Trabalhadas"),":", @ordem_servico.horas_trabalhadas]] 
    table(data,:column_widths => {2 => 200},:cell_style => {:border_width => 0, :inline_format => true})

    move_down 15
    stroke {horizontal_rule}
    move_down 15


    text "#{negritar('Descrição das atividades')}:", :inline_format => true
    move_down 3
    text @ordem_servico.descricao

    move_down 20    
    if @ordem_servico.usuarios_participantes.present?
      text "#{negritar('Usuários Participantes')}: #{@ordem_servico.usuarios_participantes}", :inline_format => true
    end
  
    if @ordem_servico.observacoes.present?
      move_down 30
      text "#{negritar('Observações')}:", :inline_format => true
      move_down 3
      text @ordem_servico.observacoes
    end  
  end

  def modulos_treinados
    return if @ordem_servico.itens.empty?
    move_down 15
    stroke {horizontal_rule}
    move_down 15
    text negritar("Módulos Treinados:"), :inline_format => true
    move_down 15
    dash(1.25, :space => 0, :phase => 0)
    data = @ordem_servico.itens.map do |item|
     [  
        item.descricao_modulo ,
        item.solucao_sub_modulo.descricao ,
        item.setor ,
        item.usuarios ,
        item.tipo_avaliacao.descricao , 
        item.situacao.descricao ,
      ]
    end
    table_header = ["Módulo","Sub Módulo","Setor","Usuários","Avaliação","Situação"]
    data.insert(0,table_header)
    table(data) do 
      cells.padding = 3
      row(0).border_width = 1
      row(0).font_style = :bold
      row(0).background_color = "FFFFCC"
      columns(0).width = 110
      columns(1).width = 160
      columns(2).width = 80
      columns(3).width = 80
      columns(4).width = 60
      columns(5).width = 50
    end 
  end

  def assinaturas
    dash(1.25, :space => 0, :phase => 0)
    @configuracao = Configuracao.first

    text_box @configuracao.mensagem_os,
              :at => [bounds.left+5, 100],
              :width => 540 unless @configuracao.mensagem_os.nil?

    font "Helvetica", :style => :bold

    stroke_horizontal_line 376, 540, :at => 35
    draw_text "Assinatura Solicitante", :inline_format => true,:at => [bounds.left+35, 25]
    
    stroke_horizontal_line 0, 194, :at => 35
    draw_text "Assinatura Responsável O.S", :inline_format => true,:at => [bounds.right-150, 25]    
  end

  def rodape
    font "Helvetica", :style => :normal
    move_down 15
    stroke_horizontal_line 0, 540, :at =>  11
    draw_text @empresa.endereco_completo, :at => [bounds.left, 0]  
  end

  def negritar(texto)
    "<b>#{texto}</b>"
  end

end