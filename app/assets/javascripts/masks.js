$(document).ready(function(){

  jQuery(function($){
    $('input[id*="hora"]').mask("99:99");
    $('input[id*="data"]').mask("99/99/9999");  
    $('input[id*="valor"]').priceFormat({ prefix: '', centsSeparator: ',', thousandsSeparator: '.',centsLimit:2});
    /*

      
      $('input[id*="phone"]').mask("(99) 9999-9999");
      $('input[id*="zip_code"]').mask("99999-999");
      $('#cpf').mask("999.999.999-99");
      $('#cnpj').mask("99.999.999/9999-99");
      $('input[id*="price"]').priceFormat({ prefix: '', centsSeparator: ',', thousandsSeparator: '.',centsLimit:2});
      $('input[id*="decimal"]').priceFormat({ prefix: '', centsSeparator: ',', thousandsSeparator: '.',centsLimit:2});
      
  
  */
  });

  
  
});

