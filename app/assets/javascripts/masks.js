$(document).ready(function(){
  setMaskFields();
});

function setMaskFields(){
  $('input[id*="hora"]').mask("99:99");
  $('input[id*="data"]').mask("99/99/9999");  
  $('input[id*="valor"]').priceFormat({ prefix: '', centsSeparator: ',', thousandsSeparator: '.',centsLimit:2});  
  $('input[id*="cnpj"]').mask("99.999.999/9999-99");
}

