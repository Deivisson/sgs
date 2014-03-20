$(document).ready(function(){
  //$("#planejamento-solicitacoes-container").sortable();
  $( "#planejamento-solicitacoes-container, #planejamento-usuarios-container" ).sortable({
    connectWith: ".connectedSortable"
  });

  // $("#planejamento-solicitacoes-container").on( "sortremove", function( event, ui ) {
  //   alert("Saindo");
  // });

  // $("#planejamento-usuarios-container").on( "sortreceive", function( event, ui ) {
  //   alert("Recebendo" +ui.item.attr("controle"));
  // });

});
