$(document).ready(function(){
  $("a#ordernar-solucoes").click(function(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer("modal-container")).dialog({
        autoOpen: false,
        width: 600,
        height: 400,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#modal-container').remove();
        }
    });
    dialog_form.load(url + ' #modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Ordenação das Soluções");
  		$("#sortable-solucoes").sortable();

    });
    dialog_form.dialog('open');
    e.preventDefault();
  });





});

