require 'doorkeeper/grape/helpers'
require 'api_helpers'

require 'v1/api_article.rb'
class API < Grape::API
  helpers ApiHelpers
  helpers Doorkeeper::Grape::Helpers

  prefix :api
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  mount V1::ApiArticle
end