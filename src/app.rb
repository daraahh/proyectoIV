require 'sinatra'
require 'json'
require_relative 'SchedManager.rb'

class App < Sinatra::Base

	before do
		@manager = SchedManager.new
	end

	get '/' do
		content_type :json
		{:status => 'OK'}.to_json
	end

	get '/status' do
		content_type :json
		{:status => 'OK'}.to_json
	end

	get '/asignaturas/:id' do |id|
		content_type :json
		resultado = @manager.getAsignatura(id)
		if resultado == nil
			status 404
			{:status => 'Error: Asignatura no encontrada.'}.to_json
		else
			resultado.to_json
		end
	end

	get '/asignaturas' do
		content_type :json
		resultado = @manager.getTodasAsignaturas
		if resultado == nil
			status 404
			{:status => 'Error: Asignaturas no encontradas'}.to_json
		else
			resultado.to_json
		end
	end

	put '/asignaturas' do
		data = JSON.parse(request.body.read)
		@manager.addAsignatura(data)
		content_type :json
		{:status => 'OK'}.to_json
	end

end
