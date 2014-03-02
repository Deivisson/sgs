$(document).ready(function(){
 	$("a#projeto-link").click(function(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 830,
        height: 650,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Abertura de Novo Projeto");
      $("#cliente-select-carrega-solucao").focus();
      $("#cliente-select-carrega-solucao").change(function(){
        carregaSolucoesCliente();
      });
      inicializaTinyMCE();
      setMaskFields();
      bindProjetoUIEvents();
      $("#project-form-tabs").tabs();
      $("#sortable").sortable();
      bindGerenciamentoCamposFrequenciaEDuracaoTreinamento();
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
  //TAB
  $("#tab-resumo-projeto").tabs();
  $("#tab-menu-projeto").tabs();
  $("#projeto-menu-aba-treinamento").css("height",$("#show-container-id").height()-40);
  $(".solucoes-container-itens").css("height",$("#show-container-id").height()-40);
  $("#projeto-menu-aba-treinamento").css("overflow","auto");


  //
  $("#remover-sub-modulos-projeto").toggle(
    function(){
      $('input[id*="solucao-modulo-id-"]').css("visibility","visible");
      $('input[id*="solucao-submodulo-id-"]').css("visibility","visible");
      $('input[id*="solucao-submodulo-id-"]').attr('checked',false);
      $('input[id*="solucao-modulo-id-"]').attr('checked',false);
      $(this).text("Cancelar");
    },
    function(){
      $('input[id*="solucao-modulo-id-"]').css("visibility","hidden");
      $('input[id*="solucao-submodulo-id-"]').css("visibility","hidden");
      $('input[id*="solucao-submodulo-id-"]').attr('checked',false);
      $('input[id*="solucao-modulo-id-"]').attr('checked',false);
      $(this).text("Remover Módulos/Sub Módulos");      
    }
  );
}); 

function bindProjetoUIEvents() {
  $("#projeto-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}

function bindGerenciamentoCamposFrequenciaEDuracaoTreinamento(){
  EtapaTreinamento = 2
  $('input[id*="projeto_etapa_ids_"]').click(function(){
    if ($(this).val() == EtapaTreinamento) {
      $("#frequencia-visita").attr("disabled",!$(this).is(":checked"));
      $("#duracao_visita_horas").attr("disabled",!$(this).is(":checked"));
    }
  });
}