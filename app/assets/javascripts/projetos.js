$(document).ready(function(){
 	$("a#projeto-link").click(function(){
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
      $(this).dialog('option',"title","Abertura de Novo Projeto");
      $("#cliente-select-id").focus();
      inicializaTinyMCE();
      setMaskFields();
      bindProjetoUIEvents();
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});

function bindProjetoUIEvents() {
  $("#projeto-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}

