require 'sinatra'
require 'json'
require_relative 'SchedManager.rb'

class App < Sinatra::Base

	get '/' do
		content_type :json
		{:status => 'OK'}.to_json
	end

	get '/status' do
		content_type :json
		{:status => 'OK'}.to_json
	end
end
