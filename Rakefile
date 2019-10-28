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

desc "Arranca la aplicación"
task :start do
	exec "rackup -x -D -s thin -p 9292 config.ru"
end

desc "Para la aplicación"
task :stop do
	exec "kill $(lsof -i :9292 -t)"
end
