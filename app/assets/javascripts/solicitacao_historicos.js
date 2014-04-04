$(document).ready(function() {
	$("#edit-solicitaco-hist").click(function(){
		var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 830,
        height: 450,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #edit-hist-solicitacao-modal-container', function(){
      $(this).dialog('option',"title","Editando Histórico da Solicitação");
      inicializaTinyMCE();
      $("#solicitacao-hist-cancel-link").click(function(){
      	$('#dialog-form').close();
      	$('#dialog-form').remove();
      });
    });
    dialog_form.dialog('open');
    e.preventDefault();
	});


$(".show-solicitaco-hist").click(function(){
		var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 830,
        height: 350,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #show-hist-solicitacao-modal-container', function(){
      $(this).dialog('option',"title","Histórico da Solicitação");
    });
    dialog_form.dialog('open');
    e.preventDefault();
	});	
});