$(document).ready(function(){
 	$("a#programacao-treinamento-link").click(function(){
    var url = $(this).attr('href');
    var dialog_form = $(getModalContainer()).dialog({
        autoOpen: false,
        width: 700,
        height: 350,
        modal: true,
        closeText: "Fechar",
        close: function() {
          $('#dialog-form').remove();
        }
    });
    dialog_form.load(url + ' #modal-container', function(){
      //to change the title, see hidden-title-label on new, edit or show page
      $(this).dialog('option',"title","Abertura de Novo Projeto");
      $("#projeto_programacao_treinamento_usuario_id").focus();
      //$("#cliente-select-carrega-solucao").change(function(){
      //  carregaSolucoesCliente();
      //});
      //inicializaTinyMCE();
      setMaskFields();
      bindProjetoProgramacaoTreinamentoUIEvents();
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});


function bindProjetoProgramacaoTreinamentoUIEvents() {
  $("#projeto-prog-treinamento-cancel-link").click(function(){
    $('#dialog-form').dialog('close');
    $('#dialog-form').remove();
  });
}
