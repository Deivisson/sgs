$(document).ready(function(){
  $("a#programacao-treinamento-link").bind('click',callProgramacaoTreinamentoModalForm);
});

function  callProgramacaoTreinamentoModalForm(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 700,
        height: 560,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title",$("#hidden-title-label-projeto-treinamento").text());
      setMaskFields();
      bindProjetoProgramacaoTreinamentoUIEvents();
      if ($("#projeto_programacao_treinamento_usuario_id").length > 0){
        $("#projeto_programacao_treinamento_usuario_id").focus();  
      } else {
        $("#projeto_programacao_treinamento_motivo_cancelamento").focus();  
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();

  // $("a#programacao-treinamento-link","a.edit-projeto-programacao-treinamentos").click(function(){
  //   var url = $(this).attr('href');
  //   var dialog_form = $(getModalContainer()).dialog({
  //       autoOpen: false,
  //       width: 700,
  //       height: 550,
  //       modal: true,
  //       closeText: "Fechar",
  //       close: function() {
  //         $('#dialog-form').remove();
  //       }
  //   });
  //   dialog_form.load(url + ' #modal-container', function(){
  //     //to change the title, see hidden-title-label on new, edit or show page
  //     $(this).dialog('option',"title","Abertura de Novo Projeto");
  //     $("#projeto_programacao_treinamento_usuario_id").focus();
  //     //$("#cliente-select-carrega-solucao").change(function(){
  //     //  carregaSolucoesCliente();
  //     //});
  //     //inicializaTinyMCE();
  //     setMaskFields();
  //     bindProjetoProgramacaoTreinamentoUIEvents();
  //   });
  //   dialog_form.dialog('open');
  //   e.preventDefault();
  // }); 
}

function bindProjetoProgramacaoTreinamentoUIEvents() {
  $("#projeto-prog-treinamento-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}

function bindShowProgramacaoTreinamentoLink(){
  $("a.show-programacao-treinamento-link,td.clickableRow").click(function(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer('show-dialog-form')).dialog({
        autoOpen: false,
        width: 700,
        height: 550,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#show-dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #show-modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title",$("#hidden-title-label-prog").text());
      $("#projeto_programacao_treinamento_usuario_id").focus();
      bindProjetoProgramacaoTreinamentoUIEvents();
      $("a.edit-projeto-programacao-treinamentos").bind('click',callProgramacaoTreinamentoModalForm);
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
}