$(document).ready(function(){

  //carrega contatos e modulos dos solucoes
  if ($("#cliente-select-id").length > 0) {
    $("#cliente-select-id").bind("change",bindEventoComboClienteOnChange);
  }

  if ($("#solucao-modulos-select-id").length > 0) {
    $("#solucao-modulos-select-id").bind("change",bindEventoComboModulos);
  }

  if ($("#modulos-select-id").length > 0) {
    $("#modulos-select-id").bind("change",bindEventoComboModulos);
  }

  //carrega usuários responsaveis
  if ($("#solicitacao-select-status-id").length > 0) {
    $("#solicitacao-select-status-id").change(function(){
      carrega_usuarios_responsaveis($(this).val());
    });
  }
  if ($("#categoria-cliente-select-id").length > 0) {
    $("#categoria-cliente-select-id").bind("change",bindCarregaClientesPorCategoria);
  }
  if ($("#solucoes-select-id").length > 0) {
    $("#solucoes-select-id").bind("change",bindCarregaModulosSolucao);
  }
  

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

function bindEventoComboClienteLoadSolucoes() {
  carregaSolucoesCliente();
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
  $("#solucao-modulos-select-id").find('optgroup').remove();
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

function bindCarregaModulosSolucao(){
  solucao_id = $("#solucoes-select-id").val();
  $("#modulos-select-id").empty();
  $("#solucao-sub-modulos-select-id").empty();
  $.getJSON("/usuario/resources/" + solucao_id + '/modulos_por_solucao.json',function(data){
    $("#modulos-select-id").append('<option></option>');
    $.each(data,function(i,item){
      option = '<option value="' + item.solucao_modulo.id + '">' + item.solucao_modulo.descricao + '</option>'
      $("#modulos-select-id").append(option);
    });
  });
}



function carregaSubModulos(){
  if ($("#solucao-modulos-select-id").length > 0) {
    modulo_id = $("#solucao-modulos-select-id").val();
  }else if($("#modulos-select-id").length > 0){
    modulo_id = $("#modulos-select-id").val();
  }
  $("#solucao-sub-modulos-select-id").empty();
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


function carregaSolucoesCliente(){
  cliente_id = $("#cliente-select-carrega-solucao").val();
  $("li[id*=projeto_solucao_id_]").remove();
  if (cliente_id > 0) {
    $.getJSON("/usuario/resources/" + cliente_id + '/solucoes_cliente.json',function(data){
      $.each(data,function(i,item){
        html = "<li id='li-projeto_solucao_id_" + item.solucao.id + "' class='choice'>" +
               "  <input type='checkbox' value='" + item.solucao.id + "' name='projeto[solucao_ids][]' id='projeto_solucao_id_"+ item.solucao.id + "'>" +
               "     <label for='projeto_solucao_ids_" + item.solucao.id + "'>" + item.solucao.descricao + "</label>" +
               "</li>";
        $("#projeto-solucoes").append(html);
      });
    });
  }  
}

function bindCarregaClientesPorCategoria(){
  categoria_cliente_id = $("#categoria-cliente-select-id").val();
  if (categoria_cliente_id=="") categoria_cliente_id = 0;
  $("#cliente-select-id").empty();
  $("#cliente-contato-select-id").empty();
  $.getJSON("/usuario/resources/" + categoria_cliente_id + '/clientes_por_categoria.json',function(data){
    $("#cliente-select-id").append('<option></option>');
    $.each(data,function(i,item){
      option = '<option value="' + item.cliente.id + '">' + item.cliente.nome + '</option>'
      $("#cliente-select-id").append(option);
    });
  });
}