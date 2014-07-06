$(document).ready(function(){
  bindCallCompromissoShow();
  bindLinkNavegacaoMes();
  bindNewCompromissoForm();
  bindCallAddNewCompromisso();
});

function  bindCallCompromissoShow(){
  $("a.show-compromisso-link").click(function(e){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer("dialog-form-show")).dialog({
        autoOpen: false,
        width: 700,
        height: 410,
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
      bindEditCompromissoForm();
      bindShowProgramacaoTreinamentoLink();
    });
    dialog_form.dialog('open');
    e.preventDefault(e);
  });
}

function bindNewCompromissoForm(){
  $("a#new-compromisso-link").click(function(e){
    callCompromissoForm($(this),e);
  });
}

function bindEditCompromissoForm(){
  $("a#edit-compromisso-link").click(function(e){
    callCompromissoForm($(this),e);
  });
}

function callCompromissoForm(element, e){
  var url = element.attr('href');
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
    $(this).dialog('option',"title",$("#hidden-title-compromisso-label").text());
      setMaskFields();
      $("#compromisso_usuario_id").focus();
      $("#compromisso-cancel-link").bind("click",cancelLink);
  });
  dialog_form.dialog('open');
  e.preventDefault(e);
}

function cancelLink()
{
  $('#dialog-form').dialog('close');
  $('#dialog-form').remove();
}

function bindLinkNavegacaoMes(){
  $("a#compromisso-mes-anterior, a#compromisso-proximo-mes").click(function(){
    var date = $(this).attr("date");
    $("#campo-data-compromisso").attr("value",date);
    $("#compromissos-search-form").submit();
  });
}

function bindCallAddNewCompromisso(){
  if ($("a#new-compromisso-link").length > 0){
    $('a.calendar-day-link').click(function(e){
      var date = $(this).attr("date");
      //date = date.replace("-","/").replace("-","/");
      $(this).attr("href",$("a#new-compromisso-link").attr("href") + "?date="+date);
      callCompromissoForm($(this),e);
    });
  }
}
