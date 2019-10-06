
require 'test-unit'
require 'json'
require_relative '../src/SchedManager.rb'

class TestProyecto < Test::Unit::TestCase

	def test_get_from_id
		@manager = SchedManager.new
		recovered = @manager.getAsignatura("110")
		assert_equal("110",recovered["id"],"elemento recuperado es el esperado")
	end

end
