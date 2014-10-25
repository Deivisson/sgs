$(document).ready(function(){
  $('input[id*="permissao-group-"]').click(function(){
    $(this).parent().find("ul").find("li > input").attr("checked",$(this).is(":checked"));
  });
});
