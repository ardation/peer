class ApiController < ApplicationController
  respond_to :json, :xml
  helper :api
  before_action { request.session_options[:skip] = true }
  before_action { request.format = 'json' unless params[:format] }
end
