# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
#
require 'yaml'

#Inicializa tabela onde ficarao algumas configuracoes do usuario
Usuario.all().each do |u|
  UsuarioConfig.find_or_create_by_usuario_id(u.id)
end

#Cria ou atualiza descricao dos status
  status_desc =[
    {:id => 1,:descricao => 'Aberto'},{:id => 2,:descricao => 'Em Análise'},{:id => 3,:descricao => 'Não Aprovado'},{:id =>  4,:descricao => 'Aguardando Desenvolvimento'},{:id => 5,:descricao => 'Em Desenvolvimento'},
    {:id => 6,:descricao => 'Desenv. Interrompido'},{:id => 7,:descricao => 'Aguardando Homologação'},{:id => 8,:descricao => 'Em Homologação'},{:id => 9,:descricao => 'Homolog. Reprovada'},
    {:id => 10,:descricao => 'Liberado Publicação'},{:id => 11,:descricao => 'Publicado'}
  ]
  status_desc.each do |desc|
    status = Status.find_or_create_by_id(desc[:id])
    status.update_attributes!(desc)
  end
  #Status.all(:conditions => "id <= 11").each{|s| s.update_attributes()}


#Consulta

if Consulta.first.nil?
  Consulta.create(:id => 1, :descricao => "Padrao")
end

#Campos defaults
if ConsultaCampo.all.empty?
  campos = [
    {:consulta_id =>1,:descricao => 'Cliente',:tabela => 'clientes',:campo => '$nome',:alias => 'cliente_nome',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Título Solicitação',:tabela => 'solicitacoes',:campo => '$titulo',:alias => 'titulo_solicitacao',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Sub Módulo',:tabela => 'projeto_sub_modulos',:campo => '$descricao',:alias => 'sub_modulo',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Status',:tabela => 'status',:campo => '$descricao',:alias => 'status_descricao',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Prioridade',:tabela => 'prioridades',:campo => '$descricao',:alias => 'prioridade_descricao',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Tipo Solicitacao',:tabela => 'tipo_pendencias',:campo => '$descricao',:alias => 'tipo_pendencia_descricao',:tipo => '',:selecionado => 1},
    {:consulta_id =>1,:descricao => 'Data Cadastro',:tabela => 'solicitacoes',:campo => '$created_at',:alias => 'cadastro_solicitacoes',:tipo => 'D',:selecionado => 0}
  ]
  campos.each {|campo| ConsultaCampo.create(campo)}
end


#Atualiza novo campo na tabela de ConsultaCampos
ConsultaCampo.all(:conditions => {:consulta_id => 1}).each do |campo|
  campo.update_attributes(:padrao => true)
end

#Devido permitir cadastrar novos Status, set flag para alguns serem padrao do sistema
#que não permitira excluir e nem editar
Status.all(:conditions => ['id <= ? ',Status::PUBLICADO]).each do |status|
  status.update_attributes(:padrao => true)
end

#Marca
Status.all(:conditions => ['id IN (11,3)']).each do |status|
  status.update_attributes(:encerramento => true)
end

#Versao do sistema 1.1
open("#{Rails.root}/db/versoes/1.1.txt") do |versao|
  VersaoSistema.find_or_create_by_id(:id => 1,:detalhe => "#{versao.read}")
end

#Alimenta tabela de Etapas
etapas = [{descricao:'Desenvolvimento'},{descricao:'Treinamento'},{descricao:'Instalação'},{descricao:'Infra-Estrutura'}]
etapas.each do |etapa|
  Etapa.where(etapa).first_or_create!
end

#Popula informacoes iniciais para a tabela de infra dos clientes já cadastrados
unless ClienteInfra.all.any?
  Cliente.all.each do |cliente|
    cliente.infra = ClienteInfra.new()
  end 
end

#Create access permissions
permissoes = YAML.load_file("#{Rails.root}/db/permissoes.yml")
permissoes.each do |k,v|
  sub_permissoes = v.extract!("itens")
  permissao = Permissao.salvar_permissao(v)
  
  sub_permissoes["itens"].each do |k,v|
    v.merge!("parent_id" => permissao.id)
    Permissao.salvar_permissao(v)
  end if sub_permissoes.any?
end