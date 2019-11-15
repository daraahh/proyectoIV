require 'sinatra'
require 'json'
require_relative 'SchedManager.rb'

class App < Sinatra::Base

	before do
		@manager = SchedManager.new
	end

	get '/' do
		content_type :json
		{:status => 'OK',:ejemplo =>{:ruta => '/asignaturas/1100',:valor =>{:nombre => 'Fundamentos de programación', :Grupo => 'B', :teoria => 'J-9:30', :practicas => ['M-11:30','J-11:30','V-11:30']}}}.to_json
	end

	get '/status' do
		content_type :json
		{:status => 'OK',:ejemplo =>{:ruta => '/asignaturas/1100',:valor =>{:nombre => 'Fundamentos de programación', :Grupo => 'B', :teoria => 'J-9:30', :practicas => ['M-11:30','J-11:30','V-11:30']}}}.to_json
	end

	get '/asignaturas/:id' do |id|
		content_type :json
		resultado = @manager.getAsignatura(id)
		if resultado == nil
			status 400
			{:status => 'Error: Asignatura no encontrada.'}.to_json
		else
			resultado.to_json
		end
	end

	get '/asignaturas' do
		content_type :json
		resultado = @manager.getTodasAsignaturas
		if resultado == nil
			status 400
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

	delete '/asignaturas/:id' do |id|
		@manager.removeAsignatura(id)
		content_type :json
		{:status => 'OK'}.to_json
	end

	error 404 do
		content_type :json
		{:status => 'Error: ruta no encontrada'}.to_json
	end

end
