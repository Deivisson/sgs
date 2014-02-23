$(document).ready(function(){
  //TAB
  $("#cliente-tabs").tabs();
  $("#solucoes-tabs").tabs();

  //marca ou desmarcaa todos os submodulos pertencentes ao módulo clicado
  $('input[id*="solucao-modulo-id"]').click(function(){
  	$(this).parent().find(':checkbox').attr('checked', this.checked);

  	//Marca e desmarca a Solução
		countCheckeds = $(this).parent().parent().find('input[type="checkbox"]:checked').length -1
		$(this).parent().parent().find('input[id*="solucao-id"]').attr('checked',countCheckeds==0 ? false : true);
  });

  //marca ou desmarca o modulos referente ao submodulos clicada. 
  //se tiver pelo menos um sub-modulo selecionado, selecionará o modulo
  $('input[id*="solucao-submodulo-id"]').click(function(){
  	countCheckeds = $(this).parent().parent().find('li > input[type="checkbox"]:checked').length
  	moduloId = $(this).attr("parent");
  	$("#"+moduloId).attr('checked',countCheckeds==0 ? false : true)
  	
  	//Marca e desmarca a Solução
  	if (countCheckeds == 0){
  		countCheckeds = $(this).parent().parent().parent().find('input[type="checkbox"]:checked').length -1
			$(this).parent().parent().parent().find('input[id*="solucao-id"]').attr('checked',countCheckeds==0 ? false : true);
  	}else{
  		$(this).parent().parent().parent().find('input[id*="solucao-id"]').attr('checked',true);
  	}
  });

  //marca ou desmarcaa todos os modulos pertencentes à solução clicada
  $('input[id*="solucao-id"]').click(function(){
  	$(this).parent().find(':checkbox').attr('checked', this.checked);
  });


});
