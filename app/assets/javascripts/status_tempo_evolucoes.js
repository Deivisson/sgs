$(document).ready(function(){
  
  statusTempoModalForm();

});


//MODAL FORM
function statusTempoModalForm(){
  $("a#status-tempo-link, a.status-tempo-link").click(function(e){
    var url = $(this).attr('href');
    callSolicitcaoModalFormToNew(url);
  });
}

function  callSolicitcaoModalFormToNew(url){
  var dialog_form = $(getModalContainer()).dialog({
      autoOpen: false,
      width: 820,
      height: 340,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#dialog-form').remove();
      }
  });

  dialog_form.load(url + ' #modal-container', function(){
    //to change the title, see hidden-title-label on new, edit or show page
    $(this).dialog('option',"title","Nova Configuração");
    //$("#cliente-select-id").bind("change",bindEventoComboClienteOnChange);
    //$("#solucao-modulos-select-id").bind("change",bindEventoComboModulos);
    //$("#tabs").tabs(); //tabify(); 
    
    //inicializaTinyMCE();
    //bindSolicitacaoUIEvents();
    setMaskFields();
    $("#tipo-pendencia").focus();
    
    /*
    if ($("#cliente-select-id").attr("disabled") == undefined) {
      $("#cliente-select-id").focus();
    } else {
      $("#cliente-contato-select-id").focus();
    }*/
  });
  dialog_form.dialog('open');
  e.preventDefault();
}

function bindSolicitacaoUIEvents() {
  $("#solicitacao-tipo-pendencia").blur(function(){
    $("#tabs").tabs({ active: 1 }); 
    $("#solicitacao-titulo").focus();
  });

  $("#solicitacao-tab1").click(function(){
    $("#cliente-select-id").focus();
  });

  $("#solicitacao-tab2").click(function(){
    $("#solicitacao-titulo").focus();
  });

  $("#solicitacao-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}