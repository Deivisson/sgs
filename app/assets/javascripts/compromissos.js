$(document).ready(function(){
  $("a.show-compromisso-link").bind('click',callCompromissoShow);
  $("a#new-compromisso-link").bind('click',callCompromissoForm);
});

function  callCompromissoShow(){
  var url = $(this).attr('href');
  var dialog_form = $(getModalContainer("dialog-form-show")).dialog({
      autoOpen: false,
      width: 700,
      height: 360,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#dialog-form-show').remove();
      }
  });
  dialog_form.load(url + ' #show-compromisso-container', function(){
    $(this).dialog('option',"title","Compromisso");
    $("a#compromisso-back-link").bind("click", function(){
      $('#dialog-form-show').dialog('close');
      $('#dialog-form-show').remove();     
    });
    $("a#edit-compromisso-link").bind('click',callCompromissoForm);
  });
  dialog_form.dialog('open');
  e.preventDefault();
}

function  callCompromissoForm(){
  var url = $(this).attr('href');
  var dialog_form = $(getModalContainer()).dialog({
      autoOpen: false,
      width: 720,
      height: 460,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#dialog-form').remove();
      }
  });
  dialog_form.load(url + ' #compromisso-form-container', function(){
    $(this).dialog('option',"title","Compromisso");
      setMaskFields();
      $("#compromisso_usuario_id").focus();
      $("#compromisso-cancel-link").bind("click",cancelLink);
  });
  dialog_form.dialog('open');
  e.preventDefault();
}

function cancelLink()
{
  $('#dialog-form').dialog('close');
  $('#dialog-form').remove();
}