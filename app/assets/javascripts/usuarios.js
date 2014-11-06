$(document).ready(function(){
  $("a#destoy-replace-usuario").click(function(e){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 600,
        height: 220,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form-usuario').remove();
        }
    });
    dialog_form.load(url + ' #pre-replace-usuario-container', function(){
      $(this).dialog('option',"title","Excluir e Substituir Usuário");
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});