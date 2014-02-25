# -*- encoding : utf-8 -*-
class Admin::StatusTempoEvolucoesController < Admin::BaseController
  before_filter :carrega_tempo_evolucao, :only => [:edit,:destroy,:update]
  before_filter :load_status, :only => [:create]
  before_filter :carrega_dados, :except => [:index,:show]

  def new
    @status_tempo_evolucao = StatusTempoEvolucao.new
    respond_with(@status_tempo_evolucao)
  end

  def edit; end

  def create
    @status_tempo_evolucao = @status.tempo_evolucoes.build(params[:status_tempo_evolucao])
    if @status_tempo_evolucao.save
      @tempo_evolucoes = @status.tempo_evolucoes
    end
    respond_with(@status_tempo_evolucao,location:admin_status_path(@status))
  end

  def update
    @status_tempo_evolucao.update_attributes(params[:status_tempo_evolucao])
    respond_with(@status_tempo_evolucao,
        location:admin_status_path(@status_tempo_evolucao.status))
  end

  def destroy
    @status_tempo_evolucao.destroy
    respond_with(@status_tempo_evolucao, 
        location:admin_status_path(@status_tempo_evolucao.status))
  end

private 
  def carrega_tempo_evolucao
    @status_tempo_evolucao = StatusTempoEvolucao.find(params[:id])  
  end

  def load_status
    @status = Status.find(params[:status_id])
  end

  def carrega_dados
    @prioridades = Prioridade.all
    @tipo_pendencias = TipoPendencia.all
  end
end
