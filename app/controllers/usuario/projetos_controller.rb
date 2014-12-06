# -*- encoding : utf-8 -*-
class Usuario::ProjetosController < Usuario::BaseController
  before_filter except:[:update,:create, :gerenciar_sub_modulos,:associar_solicitacao,
                        :criar_vinculo_solicitacao,:desfazer_vinculo_solicitacao] do |c| 
    c.instance_eval { c.permissao_usuario!(("#{action_name}_projeto").to_sym)}
  end
  before_filter :set_current_menu
  before_filter :carrega_projeto, :except => [:index,:new, :create]
  before_filter :load_clientes, except:[:show,:destroy]
  before_filter :load_usuarios, only:[:index]
  before_filter :load_dados, except:[:show,:index,:destroy]
  before_filter :get_etapas_ids, :only => [:update,:create]

  def index
    @projetos = Projeto.includes(:cliente, :usuario)
    @projetos = @projetos.search(params[:conditions])
  end

  def show
    @projeto = Projeto.find(params[:id])

    @resumo_status = Solicitacao.joins(:status)
    @resumo_status = @resumo_status.select("count(solicitacoes.id) as qtd, status.descricao as descricao_status,solicitacoes.status_id")
    @resumo_status = @resumo_status.where(projeto_id:@projeto.id).group(:status_id)
    @resumo_status = @resumo_status.where(etapa_id:Etapa::DESENVOLVIMENTO)

    @current_status = params[:status_id].present? ? Status.find(params[:status_id]) : nil
    @solicitacoes_etapa_desenvolvimento = @projeto.solicitacoes_etapa_desenvolvimento
    @solicitacoes_etapa_desenvolvimento = @solicitacoes_etapa_desenvolvimento.where(status_id:@current_status.id) unless @current_status.nil?
    
    respond_with(@projeto,:layout  => "projeto")
  end

  def new
    @projeto = Projeto.new
  end

  def edit;  end

  def create
    params[:projeto].merge!({usuario_id:current_usuario.id,status:Projeto::ATIVO})
    @projeto = Projeto.new(params[:projeto])
    @projeto.ordem = @etapas_ordem
    if @projeto.save
      flash[:notice]= "Abertura de Projeto realizada com sucesso."
    else
      load_dados
    end
    respond_with(@projeto)
  end

  def update
    @projeto.ordem = @etapas_ordem
    if @projeto.update_attributes(params[:projeto])
      flash[:notice]= "Atualizacao de Projeto realizada com sucesso."
    end    
    respond_with(@projeto)
  end

  def destroy
    @projeto.destroy
    respond_with(@projeto,:location => usuario_projetos_path)
  end

  def gerenciar_sub_modulos
    act = params["action_trigger"]
    ids = params[:solucao_sub_modulo_ids] || []
    if ids.any?
      if act.to_sym == :remove
        @projeto.projetos_sub_modulos.where(:solucao_sub_modulo_id => ids).delete_all
        flash[:notice]= "Sub Módulos Removidos com sucesso."
      else
        @projeto.solucao_sub_modulos << SolucaoSubModulo.find(ids)
        flash[:notice]= "Sub Módulos Adicionados com sucesso."
      end
    else
      flash[:notice]= "É necessário selecionar Sub Módulos."
    end
    respond_with(@projeto,:location => usuario_projeto_path(@projeto))
  end

  def associar_solicitacao
    @etapa_id = params[:etapa_id]
  end

  def criar_vinculo_solicitacao
    @falha_solicitacao = false
    if params[:solicitacao].present? && params[:etapa_id].present?
      @solicitacao = Solicitacao.find(params[:solicitacao])
      if @solicitacao.nil?
        @falha_solicitacao = true
      else
        @solicitacao.usuario_editor = current_usuario.id
        @solicitacao.vincular_projeto(@projeto,params[:etapa_id])
      end
    else
      @falha_solicitacao = true
    end
  end

  def desfazer_vinculo_solicitacao
    @solicitacao = Solicitacao.find(params[:solicitacao_id])
    @solicitacao.update_attribute(:projeto_id, nil)
  end

private
  
  def carrega_projeto
    @projeto = Projeto.find(params[:id] || params[:projeto_id] ) 
  end
  def get_etapas_ids
    @etapas_ordem = params[:projeto][:etapa_ids] || []
  end

  def load_clientes
    @clientes = Cliente.to_select
  end

  def load_usuarios
    @usuarios = Usuario.to_select
  end

  def load_dados
    @etapas = Etapa.all
    if @projeto.nil? || @projeto.cliente.nil?
      @solucoes = Solucao.all
    else
      @solucoes = @projeto.cliente.solucoes
    end
  end

  def set_current_menu
    session[:current_menu] = "projeto"
  end
end
