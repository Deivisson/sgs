$(document).ready(function(){
  //callProgramacaoLink();
 	$("a#projeto-link").click(function(e){
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
  
  //link to show programações de treinamento para o sub-modulos
  callProgramacaoLink();

  //TAB
  $("#tab-resumo-projeto").tabs();
  $("#tab-menu-projeto").tabs();
  $("#tab-infra-estrutura-abas").tabs();
  
  $("#projeto-menu-aba-treinamento").css("height",$("#show-container-id").height()-50);
  $(".solucoes-container-itens").css("height",$("#show-container-id").height()-90);
  $("#projeto-menu-aba-treinamento").css("overflow","auto");


  $("#programacao-treinamento-link").hide();
  //Controla tela para permitir remoção de sub-modulos
  $("#projeto-menu-aba-treinamento").find("[taged$='false']").hide();
  $("#remover-sub-modulos-projeto").toggle(
    function(){
      $(this).text("Cancelar Remoção").switchClass("normal-link","cancel-link",0,"easeInOutQuad")
      gerenciaChecks(true);
      $("#projeto-menu-aba-treinamento").find("[taged$='false']").hide();
      $("#action-trigger").val("remove");
      $("#adicionar-sub-modulos-projeto").hide();
      $("#programar-treinamento").hide();
      $("#submit-sub-modulos-projeto").show();
      $("#ver-programacoes-treinamento-projeto").hide();
    },
    function(){
      $(this).text("Remover Sub Módulos").switchClass("cancel-link","normal-link",0,"easeInOutQuad");
      gerenciaChecks(false);
      $("#adicionar-sub-modulos-projeto").show();
      $("#programar-treinamento").show();
      $("#ver-programacoes-treinamento-projeto").show();
      $("#submit-sub-modulos-projeto").hide();
    }
  );

  //Controla tela para permitir adição de sub-modulos
  $("#adicionar-sub-modulos-projeto").toggle(
    function (){
      gerenciaChecks(true);
      $("#projeto-menu-aba-treinamento").find("[taged$='false']").show().css("background-color","#FCFF7A");
      $(this).text("Cancelar Adição").switchClass("normal-link","cancel-link",0,"easeInOutQuad");
      $("#action-trigger").val("add");
      $("#remover-sub-modulos-projeto").hide();
      $("#programar-treinamento").hide();
      $("#ver-programacoes-treinamento-projeto").hide();
      $("#submit-sub-modulos-projeto").show();
    },
    function(){
      gerenciaChecks(false);
      $("#projeto-menu-aba-treinamento").find("[taged$='false']").hide();
      $(this).text("Adicionar Sub Módulos").switchClass("cancel-link","normal-link",0,"easeInOutQuad");      
      $("#remover-sub-modulos-projeto").show();
      $("#programar-treinamento").show();
      $("#ver-programacoes-treinamento-projeto").show();
      $("#submit-sub-modulos-projeto").hide();
    }
  );
  
  $("#programar-treinamento").toggle(
    function(){
      $(this).text("Cancelar Programação").switchClass("normal-link","cancel-link",0,"easeInOutQuad")
      gerenciaChecks(true,true);
      $("#projeto-menu-aba-treinamento").find("[taged$='false']").hide();
      $("#action-trigger").val("programar");
      $("#adicionar-sub-modulos-projeto").hide();
      $("#remover-sub-modulos-projeto").hide();
      $("#ver-programacoes-treinamento-projeto").hide();
      $("#programacao-treinamento-link").show();
    },
    function(){
      $(this).text("Programar Treinamento").switchClass("cancel-link","normal-link",0,"easeInOutQuad");
      gerenciaChecks(false);
      $("#adicionar-sub-modulos-projeto").show();
      $("#remover-sub-modulos-projeto").show();
      $("#ver-programacoes-treinamento-projeto").show();
      $("#programacao-treinamento-link").hide();
    }
  );
}); 
$("#teste-treinamento").click(function(){
  ids = "";
  link = $(this);
  href = $(this).attr("href");
  $("#projeto-menu-aba-treinamento").find("li > input:checked").each(function(){
    ids += $(this).val() + ",";
  });
 });
//---
function gerenciaChecks(op,modoProgramacao) {
  //if (modoProgramacao == undefined) { modoProgramacao = false }
  $('input[id*="solucao-modulo-id-"]').css("visibility",op ? "visible" : "hidden");
  $('input[id*="solucao-submodulo-id-"]').css("visibility",op ? "visible" : "hidden");
  $('input[id*="solucao-submodulo-id-"]').attr('checked',false);
  $('input[id*="solucao-modulo-id-"]').attr('checked',false);
  $("#action-trigger").val("");

  if(!modoProgramacao){
    $("input[programado='true']").attr('disabled',op);
  }
}

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

function callProgramacaoLink() {
  $("a.programacao-link, a#ver-programacoes-treinamento-projeto").click(function(e){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer("modal-container-index-dialog-form")).dialog({
        autoOpen: false,
        width: 1030,
        height: 450,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#modal-container-index-dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #modal-container-index-prog', function(){
      $(this).dialog('option',"title",$("#hidden-title-label-index-prog").text());
      bindShowProgramacaoTreinamentoLink();
    });
    dialog_form.dialog('open');
    e.preventDefault(e);
  });
}