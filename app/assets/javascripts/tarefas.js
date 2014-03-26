$(document).ready(function(){
  //$("#planejamento-solicitacoes-container").sortable();
  sortEvents();
  callShowModalForm();
});

function sortEvents() {
  $("#planejamento-solicitacoes-container").sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();

  $('ul[id*="planejamento-usuarios-container-"]').sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();

  // $("#planejamento-solicitacoes-container").on( "sortstart", function( event, ui ) {
  //   ui.item.text(ui.item.attr("controle"));
  // });

  $('ul[id*="planejamento-usuarios-container-"]').on( "sortreceive", function( event, ui ) {
    href = ui.item.attr("href");
    href += "&usuario_id="+$(this).attr("controle");
    ui.item.attr("saved",false);
    ui.item.text(ui.item.attr("controle"));
    //alert(ui.item.attr("controle"));
    callTarefaModalFormToNew(href);
  });
}

function  callTarefaModalFormToNew(url){
  var dialog_form = $(getModalContainer('task-dialog-form')).dialog({
      autoOpen: false,
      width: 520,
      height: 540,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#task-dialog-form').remove();
        //$("#planejamento-solicitacoes-container").append(
        $('ul[id*="planejamento-usuarios-container-"]').find("[saved$='false']").remove();
        //);
      }
  });

  dialog_form.load(url + ' #tarefa-modal-container', function(){
    //to change the title, see hidden-title-label on new, edit or show page
    $(this).dialog('option',"title","Definição Tarefa");
    $("#tarefa-cancel-link").click(function(){
      $('#task-dialog-form').dialog('close');
      $('#task-dialog-form').remove();
    });
    setMaskFields();
    $("#nivel-complexidade-id").focus();
  });
  dialog_form.dialog('open');
  e.preventDefault();
}

function callShowModalForm() {
  $("li[id*='tarefa-item-']").click(function(){
    url = $(this).attr("href")
    var dialog_form = $(getModalContainer('task-show-dialog-form')).dialog({
        autoOpen: false,
        width: 720,
        height: 440,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#task-dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #tarefa-show-modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Tarefa");
      $("#tarefa-cancel-link").click(function(){
        $('#task-show-dialog-form').dialog('close');
        $('#task-show-dialog-form').remove();
      });
    });
    dialog_form.dialog('open');
    e.preventDefault();
  }); 
}