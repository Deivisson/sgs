$(document).ready(function(){
  var AG_DESENV = 4
  var EM_DESENV = 5

  gerenciaCamposDesenvolvimento();
  gerenciaEstadoCampoValorCobranca();


  $("#solicitacao-select-status-id").change(function(){
    gerenciaCamposDesenvolvimento();
  });

  function gerenciaCamposDesenvolvimento() {
  	var statusID = $("#solicitacao-select-status-id").attr("value");
    if (statusID == AG_DESENV || statusID == EM_DESENV ) {
      	$("#desenvolvimento-section").show();
  	} else {
      	$("#desenvolvimento-section").hide();		
    }  	
  }

  $("#gera-cobranca-solicitacao").click(function(){
  	gerenciaEstadoCampoValorCobranca();
  });

  function gerenciaEstadoCampoValorCobranca(){
  	checked = $("#gera-cobranca-solicitacao").attr("checked") == "checked";
  	$("#valor-cobranca-solicitacao").attr("disabled", !checked);
  }

  solicitacaoModalForm();
});


//MODAL FORM
function solicitacaoModalForm(){
  $("a#solicitacao-link").click(function(e){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 830,
        height: 540,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });

    dialog_form.load(url + ' #modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Nova Solicitação");
      $("#cliente-select-id").bind("change",bindEventoComboClienteOnChange);
      $("#solucao-modulos-select-id").bind("change",bindEventoComboModulos);
      $("#tabs").tabs(); //tabify(); 
      
      inicializaTinyMCE();
      bindSolicitacaoUIEvents();
      setMaskFields();
      if ($("#cliente-select-id").attr("disabled") == undefined) {
        $("#cliente-select-id").focus();
      } else {
        $("#cliente-contato-select-id").focus();
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
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