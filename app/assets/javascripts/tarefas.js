$(document).ready(function(){
  //$("#planejamento-solicitacoes-container").sortable();
  $("#planejamento-solicitacoes-container").sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();

  $('ul[id*="planejamento-usuarios-container-"]').sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();

  // $("#planejamento-solicitacoes-container").on( "sortremove", function( event, ui ) {
  //   alert("Saindo");
  // });

  $('ul[id*="planejamento-usuarios-container-"]').on( "sortreceive", function( event, ui ) {
    href = ui.item.attr("href");
    href += "&usuario_id="+$(this).attr("controle");
    callTarefaModalFormToNew(href);
  });

});

function  callTarefaModalFormToNew(url){
  var dialog_form = $(getModalContainer('task-dialog-form')).dialog({
      autoOpen: false,
      width: 520,
      height: 440,
      modal: true,
      closeText: "Fechar",
      close: function() {
        $('#task-dialog-form').remove();
      }
  });

  dialog_form.load(url + ' #tarefa-modal-container', function(){
    //to change the title, see hidden-title-label on new, edit or show page
    $(this).dialog('option',"title","Definição Tarefa");
    //$("#cliente-select-id").bind("change",bindEventoComboClienteOnChange);
    //$("#solucao-modulos-select-id").bind("change",bindEventoComboModulos);
    //$("#tabs").tabs(); //tabify(); 
    
    //inicializaTinyMCE();
    //bindSolicitacaoUIEvents();
    setMaskFields();
    //$("#tipo-pendencia").focus();

  });
  dialog_form.dialog('open');
  e.preventDefault();
}