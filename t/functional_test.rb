require 'test/unit'
require 'rack/test'
require_relative '../src/app.rb'

class AppFuncTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		App
	end

	def test_raiz_ok
		get '/'
		assert last_response.ok?
		assert_equal last_response.content_type, 'application/json'
		assert_equal last_response.body, '{"status":"OK"}'
	end

	def test_status_ok
		get '/status'
		assert last_response.ok?
		assert_equal last_response.content_type, 'application/json'
		assert_equal last_response.body, '{"status":"OK"}'
	end

	def test_get_asignatura_id
		get '/asignatura/1100'
		assert last_response.ok?
		assert_equal last_response.content_type, 'application/json'
		assert_equal last_response.body, '{"nombre":"Fundamentos de programación","Grupo":"B","teoria":"J-9:30","practicas":["M-11:30","J-11:30","V-11:30"]}'
		get '/asignatura/9999'
		assert last_response.not_found?
		assert_equal last_response.content_type, 'application/json'
		assert_equal last_response.body, '{"status":"Error: Asignatura no encontrada."}'
	end

end
