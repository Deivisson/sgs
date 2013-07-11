# -*- encoding : utf-8 -*-
class Usuario::BaseController < ApplicationController
  before_filter :authenticate_usuario!
end
