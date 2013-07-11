# -*- encoding : utf-8 -*-
class Usuario::ResourcesController < Usuario::BaseController
  
  before_filter :set_root_json
    
  def cliente_contatos
    @cliente_contatos = ClienteContato.where(:cliente_id => params[:cliente_id])
    @cliente_contatos = @cliente_contatos.order(:nome)
    respond_with(@cliente_contatos)
  end

  def solucoes
    @solucoes = Solucao.to_select
  end

  def solucao_modulos
    @solucao_modulos = SolucaoModulo.for_group_options params[:cliente_id]
    respond_with(@solucao_modulos)
  end
  
  def solucao_sub_modulos
    @solucao_sub_modulos = SolucaoSubModulo.where(:solucao_modulo_id => params[:modulo_id])
    @solucao_sub_modulos = @solucao_sub_modulos.order(:descricao)
    respond_with(@solucao_sub_modulos)
  end
  
  def usuarios_responsaveis
     @usuarios = Usuario.to_select_by_status(params[:status_id])
     respond_with(@usuarios)
  end
  
private

  def set_root_json
    ActiveRecord::Base.include_root_in_json = true
  end
end
