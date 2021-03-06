$(document).ready(function(){
  bindProgramacaoTreinamentoModalForm();
  bindShowAgendaProjeto();
});

function  bindProgramacaoTreinamentoModalForm(){
  $("a#programacao-treinamento-link, a.edit-projeto-programacao-treinamentos").click(function(e){
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
      bindShowAgendaProfissional();
      if ($("#projeto_programacao_treinamento_usuario_id").length > 0){
        $("#projeto_programacao_treinamento_usuario_id").focus();  
      } else {
        $("#projeto_programacao_treinamento_motivo_cancelamento").focus();  
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
}

function bindShowProgramacaoTreinamentoLink(){
  $("a.show-programacao-treinamento-link,td.clickableRow").click(function(e){
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
      $(this).dialog('option',"title",$("#hidden-title-label-prog").text());
      $("#projeto_programacao_treinamento_usuario_id").focus();
      bindProjetoProgramacaoTreinamentoUIEvents();
      bindProgramacaoTreinamentoModalForm();
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
}

function bindProjetoProgramacaoTreinamentoUIEvents() {
  $("#projeto-prog-treinamento-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}

function bindShowAgendaProfissional(){
  $("a#agenda-profissional-link").click(function(e){
    var usuarioId = $("#projeto_programacao_treinamento_usuario_id option:selected").val();  
    if (usuarioId == "") {
      alert("Selecione o T??cnico.");
      ("projeto_programacao_treinamento_usuario_id").focus();
      e.preventDefault();
    } else {
      showAgenda($(this),usuarioId,e);
    }
  });
}

function bindShowAgendaProjeto(){
  $("a#agenda-compromisso-from-projeto").click(function(e){
    showAgenda($(this),0,e);
  });
}

function  showAgenda(element,usuarioId,e){
  var url = element.attr('href') + "?prog_treinamento=true";
  if (usuarioId > 0)
    url += element.attr('href') + "&usuario_id=" + usuarioId ;
  else
    url += "&projeto_id=" + $("#projeto-id").val();

  var dialog_form = $(getModalContainer('dialog-form-professional-agenda')).dialog({
      autoOpen: false,
      width: 1000,
      height: 600,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#dialog-form-professional-agenda').remove();
      }
  });
  dialog_form.load(url + '#show-modal-agenda-container', function(){
    if (usuarioId > 0)
      var title = "Agenda do Profissional - " + $("#hidden-title-agenda-profissional").text();
    else
      var title = "Agenda de Treinamentos do Projeto";

    $(this).dialog('option',"title",title);
    bindCallCompromissoShow();
    bindSelecionaDataParaProgramacaoTreinamento();
    bindLinkNavegacaoMes();
  });
  dialog_form.dialog('open');
  e.preventDefault();
}

function bindSelecionaDataParaProgramacaoTreinamento(){
  if ($("#projeto_programacao_treinamento_data_programacao").length > 0){
    $('a.calendar-day-link').click(function(e){
      var date = $(this).attr("date");
      date = date.replace("-","/").replace("-","/");
      $("#projeto_programacao_treinamento_data_programacao").val($.datepicker.formatDate('dd/mm/yy', new Date(date)));
      $('#dialog-form-professional-agenda').dialog('close');
      $('#dialog-form-professional-agenda').remove();
      $('#projeto_programacao_treinamento_hora_programacao').focus();
    });
  }
}