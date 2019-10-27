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
		assert_equal last_response.body, "{\"status\":\"OK\"}"
	end

	def test_status_ok
		get '/status'
		assert last_response.ok?
		assert_equal last_response.content_type, 'application/json'
		assert_equal last_response.body, "{\"status\":\"OK\"}"
	end

end
