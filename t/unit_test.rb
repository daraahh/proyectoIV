
require 'test/unit'
require 'json'
require_relative '../src/SchedManager.rb'

class TestProyecto < Test::Unit::TestCase

	setup do
		@manager = SchedManager.new
	end

	def test_get_from_id
		recovered = @manager.getAsignatura("110")
		assert_equal("110",recovered["id"],"elemento recuperado es el esperado")
	end

	def test_add_asignatura
		id_to_add = "113"
		to_add = {"id"=>id_to_add, "nombre"=>"Asignatura test", "Grupo"=>"F", "teoria"=>"J-9:30", "practicas"=>["M-11:30", "J-11:30", "V-11:30"]}
		@manager.addAsignatura(to_add)
		recovered = @manager.getAsignatura(id_to_add)
		assert_equal(id_to_add,recovered["id"],"elemento recuperado es el añadido")
	end

end
