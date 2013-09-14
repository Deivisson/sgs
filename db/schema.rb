# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130914110058) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "atendimentos", :force => true do |t|
    t.integer  "cliente_id",                                              :null => false
    t.integer  "usuario_cadastrante_id",                                  :null => false
    t.integer  "usuario_solicitante_id",                                  :null => false
    t.string   "descricao",              :limit => 50
    t.text     "observacao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "interno",                              :default => false, :null => false
  end

  add_index "atendimentos", ["cliente_id"], :name => "index_atendimentos_on_cliente_id"
  add_index "atendimentos", ["usuario_cadastrante_id"], :name => "index_atendimentos_on_usuario_cadastrante_id"
  add_index "atendimentos", ["usuario_solicitante_id"], :name => "index_atendimentos_on_usuario_solicitante_id"

  create_table "cliente_contatos", :force => true do |t|
    t.integer  "cliente_id",                 :null => false
    t.string   "nome",         :limit => 50, :null => false
    t.string   "departamento", :limit => 30
    t.string   "email",        :limit => 50
    t.string   "telefone",     :limit => 11
    t.string   "celular",      :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cliente_contatos", ["cliente_id"], :name => "index_cliente_contatos_on_cliente_id"

  create_table "clientes", :force => true do |t|
    t.string   "nome",               :limit => 50,                                                 :null => false
    t.string   "endereco",           :limit => 50
    t.string   "complemento",        :limit => 30
    t.string   "bairro",             :limit => 30
    t.string   "cidade",             :limit => 50
    t.string   "uf",                 :limit => 2
    t.string   "cep",                :limit => 8
    t.string   "telefone",           :limit => 11
    t.string   "fax",                :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "minutos_bonus",                                                   :default => 0,   :null => false
    t.decimal  "valor_hora_visita",                :precision => 10, :scale => 6, :default => 0.0, :null => false
    t.decimal  "valor_deslocamento",               :precision => 5,  :scale => 2, :default => 0.0, :null => false
  end

  create_table "clientes_solucoes", :id => false, :force => true do |t|
    t.integer "cliente_id", :null => false
    t.integer "solucao_id", :null => false
  end

  add_index "clientes_solucoes", ["cliente_id"], :name => "index_clientes_projetos_on_cliente_id"
  add_index "clientes_solucoes", ["solucao_id"], :name => "index_clientes_solucoes_on_solucao_id"

  create_table "configuracoes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "mensagem_os"
  end

  create_table "consulta_campos", :force => true do |t|
    t.integer  "consulta_id"
    t.string   "descricao",   :limit => 30,                     :null => false
    t.string   "tabela",      :limit => 30,                     :null => false
    t.string   "campo",       :limit => 100,                    :null => false
    t.string   "alias",       :limit => 30,                     :null => false
    t.string   "tipo",        :limit => 3
    t.string   "width",       :limit => 3
    t.boolean  "selecionado",                :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordem"
    t.boolean  "padrao",                     :default => false
  end

  add_index "consulta_campos", ["consulta_id"], :name => "index_consulta_campos_on_consulta_id"

  create_table "consultas", :force => true do |t|
    t.string   "descricao",  :limit => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "razao",             :limit => 50, :null => false
    t.string   "fantasia",          :limit => 40, :null => false
    t.string   "cnpj",              :limit => 14
    t.string   "endereco",          :limit => 50
    t.string   "complemento",       :limit => 30
    t.string   "cidade",            :limit => 50
    t.string   "uf",                :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "email_suporte",     :limit => 60
    t.string   "telefone",          :limit => 14
  end

  create_table "etapas", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "etapas_projetos", :force => true do |t|
    t.integer  "etapa_id"
    t.integer  "projeto_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "etapas_projetos", ["etapa_id"], :name => "index_etapas_projetos_on_etapa_id"
  add_index "etapas_projetos", ["projeto_id"], :name => "index_etapas_projetos_on_projeto_id"

  create_table "ordem_servico_itens", :force => true do |t|
    t.integer  "ordem_servico_id",                     :null => false
    t.integer  "solucao_sub_modulo_id",                :null => false
    t.integer  "tipo_avaliacao_id",                    :null => false
    t.integer  "situacao_id",                          :null => false
    t.string   "usuarios",              :limit => 100, :null => false
    t.string   "setor",                 :limit => 30,  :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "ordem_servico_itens", ["ordem_servico_id"], :name => "index_ordem_servico_itens_on_ordem_servico_id"
  add_index "ordem_servico_itens", ["situacao_id"], :name => "index_ordem_servico_itens_on_situacao_id"
  add_index "ordem_servico_itens", ["solucao_sub_modulo_id"], :name => "index_ordem_servico_itens_on_solucao_sub_modulo_id"
  add_index "ordem_servico_itens", ["tipo_avaliacao_id"], :name => "index_ordem_servico_itens_on_tipo_avaliacao_id"

  create_table "ordem_servicos", :force => true do |t|
    t.integer  "cliente_id",                                                                              :null => false
    t.integer  "local_execucao",                                                                          :null => false
    t.integer  "cliente_contato_id",                                                                      :null => false
    t.integer  "tipo_os",                                                                                 :null => false
    t.integer  "usuario_responsavel_id",                                                                  :null => false
    t.integer  "usuario_cadastrante_id",                                                                  :null => false
    t.time     "hora_inicio"
    t.time     "hora_fim"
    t.time     "tempo_intervalo"
    t.text     "descricao"
    t.text     "observacoes"
    t.string   "usuarios_participantes",   :limit => 254,                                                 :null => false
    t.decimal  "valor_total",                             :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "valor_deslocamento",                      :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                                              :null => false
    t.datetime "updated_at",                                                                              :null => false
    t.date     "data_execucao",                                                                           :null => false
    t.integer  "minutos_trabalhados",                                                    :default => 0,   :null => false
    t.integer  "minutos_faturados",                                                      :default => 0,   :null => false
    t.integer  "minutos_bonus_utilizados",                                               :default => 0,   :null => false
    t.decimal  "valor_servico",                           :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.integer  "minutos_desconto",                                                       :default => 0,   :null => false
    t.integer  "tipo_tarifacao",                                                                          :null => false
  end

  add_index "ordem_servicos", ["cliente_contato_id"], :name => "index_ordem_servicos_on_cliente_contato_id"
  add_index "ordem_servicos", ["cliente_id"], :name => "index_ordem_servicos_on_cliente_id"
  add_index "ordem_servicos", ["usuario_cadastrante_id"], :name => "index_ordem_servicos_on_usuario_cadastrante_id"
  add_index "ordem_servicos", ["usuario_responsavel_id"], :name => "index_ordem_servicos_on_usuario_responsavel_id"

  create_table "prioridades", :force => true do |t|
    t.string   "descricao",  :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projetos", :force => true do |t|
    t.string   "nome",                  :limit => 50, :null => false
    t.text     "descricao"
    t.integer  "cliente_id",                          :null => false
    t.date     "data_inicio",                         :null => false
    t.date     "data_prevista_termino",               :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "status",                              :null => false
    t.integer  "usuario_id",                          :null => false
  end

  add_index "projetos", ["cliente_id"], :name => "index_projetos_on_cliente_id"
  add_index "projetos", ["usuario_id"], :name => "index_projetos_on_usuario_id"

  create_table "situacoes", :force => true do |t|
    t.string   "descricao"
    t.boolean  "padrao",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "solicitacao_historicos", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "solicitacao_id"
    t.text     "detalhe"
    t.integer  "status_id",              :null => false
    t.integer  "usuario_responsavel_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solicitacao_historicos", ["solicitacao_id"], :name => "index_solicitacao_historicos_on_solicitacao_id"
  add_index "solicitacao_historicos", ["status_id"], :name => "index_solicitacao_historicos_on_status_id"
  add_index "solicitacao_historicos", ["usuario_id"], :name => "index_solicitacao_historicos_on_usuario_id"
  add_index "solicitacao_historicos", ["usuario_responsavel_id"], :name => "index_solicitacao_historicos_on_usuario_responsavel_id"

  create_table "solicitacoes", :force => true do |t|
    t.integer  "atendimento_id",                                                                           :null => false
    t.integer  "status_id",                                                                                :null => false
    t.integer  "prioridade_id",                                                                            :null => false
    t.integer  "solucao_sub_modulo_id",                                                                    :null => false
    t.integer  "cliente_contato_id",                                                                       :null => false
    t.integer  "usuario_responsavel_id",                                                                   :null => false
    t.integer  "tipo_pendencia_id",                                                                        :null => false
    t.string   "titulo",                   :limit => 60,                                                   :null => false
    t.text     "detalhe",                                                                                  :null => false
    t.date     "data_previsao_liberacao"
    t.datetime "data_hora_real_liberacao"
    t.string   "versao_liberacao",         :limit => 15
    t.string   "anexo",                    :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "detalhe_ultimo_historico"
    t.string   "anexo_file_name"
    t.string   "anexo_content_type"
    t.integer  "anexo_file_size"
    t.datetime "anexo_updated_at"
    t.boolean  "nao_lido",                                                              :default => false
    t.boolean  "confirmacao_leitura"
    t.integer  "ordem_servico_id"
    t.integer  "previsao_duracao_minutos"
    t.integer  "nivel_complexidade"
    t.boolean  "gera_cobranca"
    t.decimal  "valor_cobranca",                         :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.integer  "projeto_id"
    t.integer  "etapa_id"
    t.integer  "peso"
  end

  add_index "solicitacoes", ["atendimento_id"], :name => "index_solicitacoes_on_atendimento_id"
  add_index "solicitacoes", ["cliente_contato_id"], :name => "index_solicitacoes_on_cliente_contato_id"
  add_index "solicitacoes", ["etapa_id"], :name => "index_solicitacoes_on_etapa_id"
  add_index "solicitacoes", ["ordem_servico_id"], :name => "fk_solicitacoes_ordem_servicos"
  add_index "solicitacoes", ["prioridade_id"], :name => "index_solicitacoes_on_prioridade_id"
  add_index "solicitacoes", ["projeto_id"], :name => "index_solicitacoes_on_projeto_id"
  add_index "solicitacoes", ["solucao_sub_modulo_id"], :name => "index_solicitacoes_on_solucao_sub_modulo_id"
  add_index "solicitacoes", ["status_id"], :name => "index_solicitacoes_on_status_id"
  add_index "solicitacoes", ["tipo_pendencia_id"], :name => "index_solicitacoes_on_tipo_pendencia_id"
  add_index "solicitacoes", ["usuario_responsavel_id"], :name => "index_solicitacoes_on_usuario_responsavel_id"

  create_table "solucao_modulos", :force => true do |t|
    t.integer  "solucao_id"
    t.string   "descricao",  :limit => 50, :null => false
    t.string   "detalhe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solucao_modulos", ["solucao_id"], :name => "index_solucao_modulos_on_solucao_id"

  create_table "solucao_sub_modulos", :force => true do |t|
    t.integer  "solucao_modulo_id"
    t.string   "descricao",         :limit => 50, :null => false
    t.string   "detalhe"
    t.date     "data_criacao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solucao_sub_modulos", ["solucao_modulo_id"], :name => "index_solucao_sub_modulos_on_solucao_modulo_id"

  create_table "solucoes", :force => true do |t|
    t.string   "descricao",               :limit => 50,  :null => false
    t.string   "detalhe",                 :limit => 300
    t.date     "data_criacao",                           :null => false
    t.date     "data_ultima_atualizacao"
    t.string   "versao_atual",            :limit => 15
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solucoes_usuarios", :id => false, :force => true do |t|
    t.integer "solucao_id", :null => false
    t.integer "usuario_id", :null => false
  end

  add_index "solucoes_usuarios", ["solucao_id"], :name => "index_solucoes_usuarios_on_solucao_id"
  add_index "solucoes_usuarios", ["usuario_id"], :name => "index_projetos_usuarios_on_usuario_id"

  create_table "status", :force => true do |t|
    t.string   "descricao",    :limit => 30,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "padrao",                     :default => false
    t.boolean  "encerramento",               :default => false
  end

  create_table "status_usuario_cargos", :id => false, :force => true do |t|
    t.integer "status_id"
    t.integer "usuario_cargo_id"
    t.string  "status_fluxo"
  end

  add_index "status_usuario_cargos", ["status_id"], :name => "fk_status_usuario_cargos_status"
  add_index "status_usuario_cargos", ["usuario_cargo_id"], :name => "fk_status_usuario_cargos_cargos"

  create_table "tipo_avaliacoes", :force => true do |t|
    t.string   "descricao",  :limit => 30, :null => false
    t.boolean  "padrao",                   :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "tipo_pendencias", :force => true do |t|
    t.string   "descricao",  :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuario_cargos", :force => true do |t|
    t.string   "descricao",              :limit => 30,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "estima_desenvolvimento",               :default => false, :null => false
    t.boolean  "estima_instalacao",                    :default => false, :null => false
  end

  create_table "usuario_configs", :force => true do |t|
    t.integer  "usuario_id"
    t.text     "assinatura_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "versao_sistema_id", :default => 0
  end

  add_index "usuario_configs", ["usuario_id"], :name => "index_usuario_configs_on_usuario_id"

  create_table "usuarios", :force => true do |t|
    t.integer  "usuario_cargo_id"
    t.string   "nome",                 :limit => 50, :null => false
    t.string   "email",                              :null => false
    t.string   "celular",              :limit => 11
    t.string   "encrypted_password",   :limit => 40, :null => false
    t.string   "password_salt",                      :null => false
    t.string   "confirmation_token",   :limit => 20
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token", :limit => 20
    t.string   "remember_token",       :limit => 20
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["usuario_cargo_id"], :name => "index_usuarios_on_usuario_cargo_id"

  create_table "versao_sistemas", :force => true do |t|
    t.string   "versao",     :limit => 10
    t.text     "detalhe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "atendimentos", "clientes", :name => "fk_atendimentos_clientes"
  add_foreign_key "atendimentos", "usuarios", :name => "fk_atendimentos_usuario_cadastrante", :column => "usuario_cadastrante_id"
  add_foreign_key "atendimentos", "usuarios", :name => "fk_atendimentos_usuario_solicitante", :column => "usuario_solicitante_id"

  add_foreign_key "cliente_contatos", "clientes", :name => "fk_cliente_contatos_clientes"

  add_foreign_key "clientes_solucoes", "clientes", :name => "clientes_projetos_cliente_id_fk", :dependent => :delete
  add_foreign_key "clientes_solucoes", "solucoes", :name => "fk_solucoes_clientes"

  add_foreign_key "consulta_campos", "consultas", :name => "fk_consulta_campos_consultas"

  add_foreign_key "etapas_projetos", "etapas", :name => "fk_etapas_projetos_etapas"
  add_foreign_key "etapas_projetos", "projetos", :name => "fk_etapas_projetos_projetos"

  add_foreign_key "ordem_servico_itens", "ordem_servicos", :name => "fk_ordem_servico_itens_ordem_servico"
  add_foreign_key "ordem_servico_itens", "situacoes", :name => "fk_ordem_servico_itens_situacoes"
  add_foreign_key "ordem_servico_itens", "solucao_sub_modulos", :name => "fk_solucao_sub_modulos_ordem_servico_itens"
  add_foreign_key "ordem_servico_itens", "tipo_avaliacoes", :name => "fk_ordem_servico_itens_tipo_avaliacoes"

  add_foreign_key "ordem_servicos", "cliente_contatos", :name => "fk_ordem_servicos_cliente_contato"
  add_foreign_key "ordem_servicos", "clientes", :name => "fk_ordem_servicos_cliente"
  add_foreign_key "ordem_servicos", "usuarios", :name => "fk_ordem_servicos_usuarios_cadastrantes", :column => "usuario_cadastrante_id"
  add_foreign_key "ordem_servicos", "usuarios", :name => "fk_ordem_servicos_usuarios_responsaveis", :column => "usuario_responsavel_id"

  add_foreign_key "projetos", "clientes", :name => "fk_projetos_clientes"

  add_foreign_key "solicitacao_historicos", "solicitacoes", :name => "fk_solicitacao_historico_solicitacoes", :dependent => :delete
  add_foreign_key "solicitacao_historicos", "status", :name => "fk_solicitacao_historico_status"
  add_foreign_key "solicitacao_historicos", "usuarios", :name => "fk_solicitacao_historico_usuario_responsavel", :column => "usuario_responsavel_id"
  add_foreign_key "solicitacao_historicos", "usuarios", :name => "fk_solicitacao_historico_usuarios"

  add_foreign_key "solicitacoes", "atendimentos", :name => "fk_solicitacoes_atendimentos"
  add_foreign_key "solicitacoes", "cliente_contatos", :name => "fk_solicitacoes_cliente_contatos_id"
  add_foreign_key "solicitacoes", "etapas", :name => "fk_solicitacoes_etapas"
  add_foreign_key "solicitacoes", "ordem_servicos", :name => "fk_solicitacoes_ordem_servicos"
  add_foreign_key "solicitacoes", "prioridades", :name => "fk_solicitacoes_prioridades"
  add_foreign_key "solicitacoes", "projetos", :name => "fk_solicitacoes_projetos"
  add_foreign_key "solicitacoes", "solucao_sub_modulos", :name => "fk_solucao_sub_modulos_solicitacoes"
  add_foreign_key "solicitacoes", "status", :name => "fk_solicitacoes_status"
  add_foreign_key "solicitacoes", "tipo_pendencias", :name => "fk_solicitacoes_tipo_pendencias"
  add_foreign_key "solicitacoes", "usuarios", :name => "fk_pendencias_itens_usuario_responsavel", :column => "usuario_responsavel_id"

  add_foreign_key "solucao_modulos", "solucoes", :name => "fk_modulos_solucoes"

  add_foreign_key "solucao_sub_modulos", "solucao_modulos", :name => "fk_solucao_sub_modulos_projeto_modulos"

  add_foreign_key "solucoes_usuarios", "solucoes", :name => "fk_solucoes_solucoes_usuarios"
  add_foreign_key "solucoes_usuarios", "usuarios", :name => "projetos_usuarios_usuario_id_fk", :dependent => :delete

  add_foreign_key "status_usuario_cargos", "status", :name => "fk_status_usuario_cargos_status"
  add_foreign_key "status_usuario_cargos", "usuario_cargos", :name => "fk_status_usuario_cargos_cargos"

  add_foreign_key "usuario_configs", "usuarios", :name => "usuario_configs_usuario_id_fk", :dependent => :delete

  add_foreign_key "usuarios", "usuario_cargos", :name => "fk_usuarios_usuarios_cargos"

end
