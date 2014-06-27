$(document).ready(function(){
  $("a#ordernar-solucao-sub-modulos").click(function(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer("modal-container")).dialog({
        autoOpen: false,
        width: 600,
        height: 750,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#modal-container').remove();
        }
    });
    dialog_form.load(url + ' #modal-container', function(){
      $(this).dialog('option',"title","Ordenação de Sub Módulos");
  		$("#sortable-solucao-sub-modulos").sortable();
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});

