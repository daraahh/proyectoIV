require 'rake/testtask'

Rake::TestTask.new do |task|
	task.name = "test"
	task.description = "Ejecución de todos los tests"
	task.test_files = FileList["t/*test.rb"]
end

Rake::TestTask.new do |task|
	task.name = "unit_tests"
	task.description = "Ejecución de tests unitarios"
	task.test_files = FileList["t/unit_test.rb"]
end

Rake::TestTask.new do |task|
	task.name = "functional_tests"
	task.description = "Ejecución de tests funcionales"
	task.test_files = FileList["t/functional_test.rb"]
end
