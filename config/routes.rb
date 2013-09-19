Sgsoft::Application.routes.draw do

  resources :ordem_servico_itens

  devise_for :admins, :controllers => { :sessions => "usuario/sessions" }
  devise_for :usuarios, :controllers => { :sessions => "usuario/sessions" }


  namespace :admin do
    resources :empresas
    resources :solucoes
    resources :solucao_modulos
    resources :solucao_sub_modulos
    resources :clientes
    resources :cliente_contatos
    resources :usuarios
    resources :usuario_cargos
    resources :tipo_pendencias
    resources :prioridades
    resources :status
    resources :configuracoes
    resources :consultas
    resources :etapas
    resources :consulta_campos do
      collection do
        put :update_individual
        post :sort
      end
    end
  end

  namespace :usuario do
    resources :versao_sistemas
    resources :usuario_configs
    resources :atendimentos
    resources :solicitacao_historicos
    resources :projetos do 
      resources :solicitacoes
    end
    resources :solicitacao_pesquisas do
       post :find,  :on =>  :collection
    end

    resources :solicitacoes do
    	 collection do
    	 	post :edit_multiple
    	 	put  :update_multiple
    	 	get :search
    	 end

	  end
    get 'solicitacoes/:id/programar', :to => 'solicitacoes#programar', :as => "programar_solicitacao"
    resources :ordem_servicos 
    get '/ordem_servico/:ordem_servico_id/:cliente_id/carrega_solicitacoes', 
            :to => 'ordem_servicos#carrega_solicitacoes', 
            :as => "carrega_solicitacoes_ordem_servico"
            
    get '/:cliente_id/adiciona_item', :to => 'ordem_servicos#adiciona_item', :as => "adiciona_item_ordem_servico"
    get '/resources/:cliente_id/cliente_contatos', :to => 'resources#cliente_contatos'
    get '/resources/:cliente_id/solucao_modulos', :to => 'resources#solucao_modulos'
    get '/resources/:modulo_id/solucao_sub_modulos', :to => 'resources#solucao_sub_modulos'
    get '/resources/:status_id/usuarios_responsaveis', :to => 'resources#usuarios_responsaveis'


  end
  # scope '/usuario' do
  #   devise_for :usuarios, :controllers => {
  #       :sessions      => "usuario/sessions"
  #     }
  # end
	root :to => "usuario/solicitacoes#index"

end
