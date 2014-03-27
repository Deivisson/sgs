$(document).ready(function(){
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
    href = ui.item.attr("edit_href");
    if (href == undefined) { 
      //Add a new Tarefa
      href = ui.item.attr("href");
      href += "&usuario_id="+$(this).attr("controle");
      ui.item.attr("saved",false);
      ui.item.text(ui.item.attr("controle"));
    }
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
        $('ul[id*="planejamento-usuarios-container-"]').find("[saved$='false']").remove();
      }
  });

  dialog_form.load(url + ' #tarefa-modal-container', function(){
    $(this).dialog('option',"title",$("#title-task-form").text());
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
  $("li[id*='tarefa-item-']").dblclick(function(){
    url = $(this).attr("href")
    var dialog_form = $(getModalContainer('task-show-dialog-form')).dialog({
        autoOpen: false,
        width: 720,
        height: 440,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#task-show-dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #tarefa-show-modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Detalhes do Planejamento");
      $("#tarefa-cancel-link").click(function(){
        $('#task-show-dialog-form').dialog('close');
        $('#task-show-dialog-form').remove();
      });
      $("#edit-tarefa").click(function(){
        href = $(this).attr("href");
        callTarefaModalFormToNew(href);
      });
    });
    dialog_form.dialog('open');
    e.preventDefault();
  }); 
}