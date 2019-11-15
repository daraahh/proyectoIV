require 'test/unit'
require 'rack/test'
require_relative '../src/app.rb'

class AppFuncTest < Test::Unit::TestCase
	include Rack::Test::Methods

	setup do
		#Generamos datos de prueba "limpios" para la ejecución de cada test
		@sampledata = {"asignaturas"=>{"1100"=>{"nombre"=>"Fundamentos de programación", "Grupo"=>"B", "teoria"=>"J-9:30", "practicas"=>["M-11:30", "J-11:30", "V-11:30"]}, "1101"=>{"nombre"=>"Fundamentos del Software", "Grupo"=>"B", "teoria"=>"X-11:30", "practicas"=>["J-11:30", "M-11:30", "L-11:30"]}, "1102"=>{"nombre"=>"Fundamentos Físicos y Tecnológicos", "Grupo"=>"B", "teoria"=>"L-9:30", "practicas"=>["V-11:30", "L-11:30", "M-11:30"]}, "1104"=>{"nombre"=>"ASIGNATURA A ELIMINAR", "Grupo"=>"B", "teoria"=>"L-9:30", "practicas"=>["V-11:30", "L-11:30", "M-11:30"]}}}
		@path = File.join(File.dirname(__FILE__),'../sampledata/sampledata.json')
		File.open(@path, "w") do |f|
			f.puts JSON.pretty_generate(@sampledata)
		end
	end

	def app
		App
	end

	def test_raiz_ok
		get '/'
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"OK","ejemplo":{"ruta":"/asignaturas/1100","valor":{"nombre":"Fundamentos de programación","Grupo":"B","teoria":"J-9:30","practicas":["M-11:30","J-11:30","V-11:30"]}}}', "status ok")
	end

	def test_status_ok
		get '/status'
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"OK","ejemplo":{"ruta":"/asignaturas/1100","valor":{"nombre":"Fundamentos de programación","Grupo":"B","teoria":"J-9:30","practicas":["M-11:30","J-11:30","V-11:30"]}}}', "status ok")
	end

	def test_get_asignatura_id
		get '/asignaturas/1100'
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"nombre":"Fundamentos de programación","Grupo":"B","teoria":"J-9:30","practicas":["M-11:30","J-11:30","V-11:30"]}', "asignatura indicada encontrada")
		get '/asignaturas/9999'
		assert last_response.bad_request?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"Error: Asignatura no encontrada."}', "Asignatura inexistente no encontrada")
	end

	def test_get_asignaturas
		get '/asignaturas'
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(JSON.parse(last_response.body)['asignaturas']['1100']['nombre'], 'Fundamentos de programación', "devueltas todas las asignaturas")
	end

	def test_put_add_asignatura
		id_to_add = "1103"
		to_add = {id_to_add => {"nombre"=>"Asignatura test", "Grupo"=>"F", "teoria"=>"J-9:30", "practicas"=>["M-11:30", "J-11:30", "V-11:30"]}}
		put '/asignaturas', to_add.to_json
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"OK"}', "elemento añadido")
	end

	def test_delete_asignatura
		id_to_remove = "1104"
		delete '/asignaturas/' + id_to_remove.to_s
		assert last_response.ok?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"OK"}')
		get '/asignaturas/' + id_to_remove.to_s
		assert last_response.bad_request?
		assert_equal(last_response.content_type, 'application/json')
		assert_equal(last_response.body, '{"status":"Error: Asignatura no encontrada."}', 'elemento ha sido eliminado')
	end

end
