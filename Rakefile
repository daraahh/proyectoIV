require 'rake/testtask'

task :default => ["install"]

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

desc "Instalar las dependencias necesarias"
task :install do
	exec "bundle install"
end

desc "Arranca la aplicación"
task :start do
  exec "pm2 start sinatra_app.json"
end

desc "Para la aplicación"
task :stop do
  exec "pm2 stop sinatra-app-IV"
end

desc "Elimina el proceso"
task :delete do
  exec "pm2 delete sinatra-app-IV"
end
