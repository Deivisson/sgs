$(document).ready(function(){
  $("a#edit-cliente-check-list-itens").click(function(e){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 1000,
        height: 360,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #cliente-check-list-itens-form-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Atualização de Itens de Check-List");
      setMaskFields();
      if ($("#check_lists__1_disponivel").length > 0){
        $("#check_lists__1_disponivel").focus();  
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});