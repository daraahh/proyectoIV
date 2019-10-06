require 'rake/testtask'

task default: "test"

Rake::TestTask.new do |task|
	#Nombre por defecto es test
	task.description = "Ejecución de todos los tests"
	task.test_files = FileList["t/*test.rb"]
end

Rake::TestTask.new do |task|
	task.name = "unit_tests"
	task.description = "Ejecución de tests unitarios"
	task.test_files = FileList["t/unit_test.rb"]
end
