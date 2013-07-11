$(document).ready(function(){

	var TARIFACAO_ORCAMENTO = 1;
	var TIPO_OS_DESENVOLVIMENTO = 3;
	var TIPO_OS_TREINAMENTO = 0

  	$('a[class*="remove-item-link"]').bind("click",removeItem);

	$("#add-item-link").click(function(){
		var itemIndex = $('#ordem-servico-itens').find('.dynamic-itens-row').size() - 1;
		var removeLink = "add-item-link-"+itemIndex;

		var html  = ""
		html += "<tr class='dynamic-itens-row'>" 
		html +=  getField(itemIndex,"solucao_modulo_id","solucao-modulos-select-id","modulos");
		html +=  getField(itemIndex,"solucao_sub_modulo_id","solucao-sub-modulos-select-id","sub-modulos");
		html +=  getField(itemIndex,"setor","","free-texts");
		html +=  getField(itemIndex,"usuarios","","free-texts");
		html +=  getField(itemIndex,"tipo_avaliacao_id");
		html +=  getField(itemIndex,"situacao_id");
		html +=  "<td>"
		html +=  "	<a class='remove-item-link' href='#'><img src='/assets/icons/24/remove.png' alt='Add'></a>"
		html +=  "</td>"		
		html += "</tr>" 
		$("#ordem-servico-itens").append(html);
		$("#solucao-modulos-select-id").focus();
		$(".remove-item-link").bind("click",removeItem);
	});

	function getField(index,fieldName,fieldKey,tdClass){
		fieldKey = fieldKey || fieldName;
		tdClass = tdClass || "default";

		type = $("#"+fieldKey).attr("type"); 
		type = (type =="text" ? "input" : "select")

		var html = ""
		html += "<td class='"+ tdClass+ "'>"
		html +=	type == "input" ? getInput(index,fieldName,fieldKey) : getCombo(index,fieldName,fieldKey)
		html += "</td>"
		
		return html;
	}

	function getInput(index,fieldName,fieldKey,hidden,disabled){
		fieldKey = fieldKey || "";
		hidden = hidden || false;
		disabled = disabled || false;

		name ="";
		if (fieldName!="")
			name = "ordem_servico[itens_attributes]["+ index +"]["+fieldName +"]";

		var html = ""
		html +=	"<input name='"+name+"'"
		html += "value='" + getValue(fieldKey,hidden) + "' type ='"+ (hidden ? "hidden"  : "text") + "'"
		html +=  disabled ?  "disabled ='disabled'" : ""
		html += ">" 
		return html;
	}

	function getCombo(index,fieldName,fieldKey){
		fieldKey = fieldKey || "";
		var html = ""
		if(fieldKey=="solucao-modulos-select-id" || fieldKey=="solucao-sub-modulos-select-id") {
			html +=	getInput(index,fieldName,fieldKey,true);
			html +=	getInput(index,"",fieldKey,false,true);	
	  } else {
	  	html +=	"<select name='ordem_servico[itens_attributes]["+ index +"]["+fieldName +"]'>"	
			html += getOption(fieldKey) + "</select>";
	  }
	  limpaCombo(fieldKey);
		return html;
	}

	function getValue(fieldKey, isHiddenOrCombo) {
		var type = $("#"+fieldKey).attr("type"); 
		var value = "";
		if (type =="text") {
			value = $("#"+fieldKey).val();
		} else {
			var index = document.getElementById(fieldKey).selectedIndex;
			if (isHiddenOrCombo) {
				value = $("#"+fieldKey).val();
			}else {
				value = document.getElementById(fieldKey).options[index].text;
			}
		}	
		return value;
	}
	
	function getOption(fieldKey) {
		var index = document.getElementById(fieldKey).selectedIndex;
		var text = document.getElementById(fieldKey).options[index].text;
		document.getElementById(fieldKey).options[index].selectedIndex = -1;
		return "<option value='"+getValue(fieldKey,true)+"'>" + text + "</option>";
	}	

	function limpaCombo(fieldKey){
		$("#"+fieldKey).val('');
	}

	//if($("#ordem_servico_tipo_os").attr("value") != 0){$("#modulos-treinados-section").hide();}
	gerenciaPartials();
	habilitarCampoValor();
	$('#ordem_servico_tipo_os').change(function(){
		gerenciaPartials();
		habilitarCampoValor();
	});

	habilitarCampoValor();
	$('#ordem_servico_tipo_tarifacao').change(function(){
		gerenciaPartials();
		habilitarCampoValor();
	});

	function habilitarCampoValor() {
		var tipoTarifacao = $('#ordem_servico_tipo_tarifacao').attr("value");
		var tipoOS = $('#ordem_servico_tipo_os').attr("value");

		var b = !(tipoTarifacao == TARIFACAO_ORCAMENTO && 
				  tipoOS != TIPO_OS_DESENVOLVIMENTO )
		$("#valor-servico").attr("disabled",b);
	}

	function gerenciaPartials() {
		var tipoTarifacao = $('#ordem_servico_tipo_tarifacao').attr("value");
		var tipoOS = $('#ordem_servico_tipo_os').attr("value");
		
		$("#modulos-treinados-section").hide();
		$("#solicitacoes-section").hide();

		if(tipoOS == TIPO_OS_TREINAMENTO) {
			$("#modulos-treinados-section").show(); 

		}else if(tipoOS == TIPO_OS_DESENVOLVIMENTO && 
				 tipoTarifacao == TARIFACAO_ORCAMENTO ){
			$("#solicitacoes-section").show(); 
			var cliente_id = $("#cliente-select-id").attr("value");
			var ordem_servico_id = $("#ordem-servico-id").attr("value");
			ordem_servico_id = (ordem_servico_id != "" ? ordem_servico_id : 0);
			
			$('#myLink').attr("href", "/usuario/ordem_servico/" + ordem_servico_id + "/" + cliente_id + "/carrega_solicitacoes");
			$('#myLink').attr("data-remote", "true");
			$('#myLink').click();	
		};
	}

	function removeItem(){
		if ($(this).parent("td").find("input") != null) {
			$(this).parent("td").find("input").attr("value","true");	
			$(this).parent("td").parent(".dynamic-itens-row").hide();	
		}else{
			$(this).parent("td").parent(".dynamic-itens-row").remove();	
		}
	}



	///$("#tab-menu").tabify(); 
	
});

