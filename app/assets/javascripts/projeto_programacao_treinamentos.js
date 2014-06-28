$(document).ready(function(){
  bindProgramacaoTreinamentoModalForm();
  bindCallCompromissoShow();
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
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title",$("#hidden-title-label-prog").text());
      $("#projeto_programacao_treinamento_usuario_id").focus();
      bindProjetoProgramacaoTreinamentoUIEvents();
      bindProgramacaoTreinamentoModalForm();
      //$("a.edit-projeto-programacao-treinamentos").bind('click',callProgramacaoTreinamentoModalForm);
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
    usuarioId = $("#projeto_programacao_treinamento_usuario_id option:selected").val();
    if (usuarioId == "") {
      alert("Selecione o Técnico.");
      ("projeto_programacao_treinamento_usuario_id").focus();
      e.preventDefault();
    } else {
      var url = $(this).attr('href') + "?usuario_id=" + usuarioId;
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
        $(this).dialog('option',"title", "Agenda do Profissional");
        bindCallCompromissoShow();
        bindSelecionaDataParaProgramacaoTreinamento();
      });
      dialog_form.dialog('open');
      e.preventDefault();
    }
  });
}

function bindSelecionaDataParaProgramacaoTreinamento(){
  $('a.calendar-day-link').click(function(e){
    var date = $(this).attr("date");
    date = date.replace("-","/").replace("-","/");
    $("#projeto_programacao_treinamento_data_programacao").val($.datepicker.formatDate('dd/mm/yy', new Date(date)));
    $('#dialog-form-professional-agenda').dialog('close');
    $('#dialog-form-professional-agenda').remove();
  });
}