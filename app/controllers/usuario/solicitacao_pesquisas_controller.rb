# -*- encoding : utf-8 -*-
class Usuario::SolicitacaoPesquisasController < Usuario::BaseController

  layout "full_layout"

  def index
    @filtro = params[:filtro]
    carrega_solicitacoes
    respond_to do |format|
      format.pdf {render :layout => false}
    end
  end

  def new
    carrega_dados
  end

  #need refactory
  def find

    #Monta Filtro
    @filtro =  " solicitacoes.id > 0"
    @filtro += " AND clientes.id IN (#{params[:cliente_ids]})" if not params[:cliente_ids].empty? #Filtra Cliente
    if !params[:solicitante_ids].nil? && !params[:solicitante_ids].empty? #Filtra Solicitante -- Contato do Cliente
      @filtro += " AND cliente_contato_id IN (#{params[:solicitante_ids]})"  
    end
    @filtro += " AND usuario_cadastrante_id IN (#{params[:cadastrante_ids]})" if not params[:cadastrante_ids].empty?  #Filtra Usuario cadastrante
    @filtro += " AND usuario_responsavel_id IN (#{params[:usuario_ids]})" if not params[:usuario_ids].empty? #Filtra Usuario
    @filtro += " AND solucoes.id IN (#{params[:solucao_ids]})" if not params[:solucao_ids].empty?  #Filtra Solucoes
    @filtro += " AND solucao_modulos.id IN (#{params[:modulo_ids]})" if not params[:modulo_ids].empty? #Filtra Módulos
    @filtro += " AND solucao_sub_modulos.id IN (#{params[:sub_modulo_ids]})" if not params[:sub_modulo_ids].empty? #Filtra sub modulo
    @filtro += " AND status.id IN (#{params[:status_ids]})"  if not params[:status_ids].empty? #Filtra Status
    @filtro += " AND prioridade_id IN (#{params[:prioridade_ids]})" if not params[:prioridade_ids].empty?  #Filtra Prioridade
    @filtro += " AND tipo_pendencia_id IN (#{params[:tipo_ids]})" if not params[:tipo_ids].empty?    #Filtra Tipo de Pendencias

    carrega_solicitacoes

    respond_to do |format|
      format.html
      format.pdf {render :layout => true}
    end
  end


  def carrega_solicitacoes
    @campos = Array.new

    #Recupera campos a serem exibidos
    consulta_campos = ConsultaCampo.all(
      :select => "consultas.*,consulta_campos.*",
      :joins => [:consulta],
      :conditions => {:selecionado => true},
      :order => :ordem )

    #Monta sql
    @sql = "solicitacoes.id,solicitacoes.status_id,solicitacoes.data_status,solicitacoes.tipo_pendencia_id,
            solicitacoes.prioridade_id,"

    for campo in consulta_campos do
      @sql = "#{@sql}#{campo.campo.gsub("$","#{campo.tabela}." )} as #{campo.alias},"
      @campos << [campo.descricao,campo.alias,campo.tipo]
    end
    @sql = @sql.slice(0,@sql.size-1)


    @solicitacoes = Solicitacao.all(:select => @sql,
      :joins => [{:cliente_contato => [:cliente]},
                 {:solucao_sub_modulo => [:solucao_modulo => [:solucao]]},
                 :status,:prioridade,:tipo_pendencia],
      :conditions => @filtro )

  end


private

  def carrega_dados
    @clientes = Cliente.order(:nome)
    @usuarios = Usuario.where("id > 1").order(:nome)
    @solucoes = Solucao.all #.order(:description)
    @modulos = SolucaoModulo.all
    @sub_modulos = SolucaoSubModulo.all
    @status = Status.all
    @prioridades = Prioridade.all
    @tipo_pendencias = TipoPendencia.find(:all)
  end
end
