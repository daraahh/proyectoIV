
require 'test/unit'
require 'json'
require_relative '../src/SchedManager.rb'

class TestProyecto < Test::Unit::TestCase

	setup do
		@manager = SchedManager.new
	end

	def test_get_from_id
		expected = {"nombre"=>"Fundamentos de programación", "Grupo"=>"B", "teoria"=>"J-9:30", "practicas"=>["M-11:30", "J-11:30", "V-11:30"]}
		recovered = @manager.getAsignatura("1100")
		assert_equal(expected,recovered,"elemento recuperado es el esperado")
	end

	def test_add_asignatura
		id_to_add = "1103"
		to_add = {id_to_add => {"nombre"=>"Asignatura test", "Grupo"=>"F", "teoria"=>"J-9:30", "practicas"=>["M-11:30", "J-11:30", "V-11:30"]}}
		@manager.addAsignatura(to_add)
		recovered = @manager.getAsignatura(id_to_add)
		assert_equal(to_add[id_to_add],recovered,"elemento recuperado es el añadido")
	end

	def test_remove_asignatura
		to_remove = "1103"
		@manager.removeAsignatura(to_remove)
		recovered = @manager.getAsignatura(to_remove)
		assert_equal(nil,recovered,"elemento ha sido eliminado")
	end

end
