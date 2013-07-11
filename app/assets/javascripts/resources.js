$(document).ready(function(){

  //carrega contatos e modulos dos solucoes
  $("#cliente-select-id").bind("change",bindEventoComboClienteOnChange);

  $("#solucao-modulos-select-id").bind("change",bindEventoComboModulos);

  //carrega usuários responsaveis
  $("#solicitacao-select-status-id").change(function(){
    carrega_usuarios_responsaveis($(this).val());
  });

  function carrega_usuarios_responsaveis(status_id){
    $("#select-usuarios-responsaveis").empty();
    if (status_id > 0) {
        $.getJSON("/usuario/resources/" + status_id + '/usuarios_responsaveis.json',function(data){
          $("#select-usuarios-responsaveis").append('<option></option>');
          $.each(data,function(i,item){
            option = '<option value="' + item.usuario.id + '">' + item.usuario.nome + '</option>'
            $("#select-usuarios-responsaveis").append(option);
          });
        });
    }
  }

});

function bindEventoComboClienteOnChange() {
  carregaContatos();
  carregaModulos();
}

function bindEventoComboModulos() {
  carregaSubModulos();
}

function carregaContatos(){
  cliente_id = $("#cliente-select-id").val();
  $("#cliente-contato-select-id").empty();
  if (cliente_id > 0) {
      $.getJSON("/usuario/resources/" + cliente_id + '/cliente_contatos.json',function(data){
        $("#cliente-contato-select-id").append('<option></option>');
        $.each(data,function(i,item){
          option = '<option value="' + item.cliente_contato.id + '">' + item.cliente_contato.nome + '</option>'
          $("#cliente-contato-select-id").append(option);
        });
      });
  }
}

function carregaModulos(){
  cliente_id = $("#cliente-select-id").val();
  $("#solucao-modulos-select-id").find('option').remove();
  if (cliente_id > 0) {
    $.getJSON("/usuario/resources/" + cliente_id + '/solucao_modulos.json',function(data){
      $("#solucao-modulos-select-id").append('<option></option>');
      group = "";
      options = "";
      $.each(data,function(i,item){
        if (group != item.solucao_modulo.desc_solucao) {
          if (group != "") {
            $("#solucao-modulos-select-id").append('<optgroup label="' + group +'">' + options + '</optgroup>');
          }
          group = item.solucao_modulo.desc_solucao
          options = "";
        }
        options += '<option value="' + item.solucao_modulo.id + '">' + item.solucao_modulo.desc_modulo + '</option>'
      });
      if (group != ""){
        $("#solucao-modulos-select-id").append('<optgroup label="' + group +'">' + options + '</optgroup>');
      }
    });
  }

}

function carregaSubModulos(){
  $("#solucao-sub-modulos-select-id").empty();
  modulo_id = $("#solucao-modulos-select-id").val();
  if (modulo_id > 0) {
    $.getJSON("/usuario/resources/" + modulo_id + '/solucao_sub_modulos.json',function(data){
      $("#solucao-sub-modulos-select-id").append('<option></option>');
      $.each(data,function(i,item){
        option = '<option value="' + item.solucao_sub_modulo.id + '">' + item.solucao_sub_modulo.descricao + '</option>'
        $("#solucao-sub-modulos-select-id").append(option);
      });
    });
  }
}