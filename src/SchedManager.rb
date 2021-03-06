require 'json'

class SchedManager

	def initialize
		@path = File.join(File.dirname(__FILE__),'../sampledata/sampledata.json')
		@file = File.read(@path)
		@data = JSON.parse(@file)
	end

	def write2file()
		File.open(@path, "w") do |f|
			f.puts JSON.pretty_generate(@data)
		end
	end

	def getTodasAsignaturas()
		@data
	end

	def getAsignatura(id)
		@data["asignaturas"][id]
	end

	def addAsignatura(info)
		@data["asignaturas"] = @data["asignaturas"].merge(info)
		write2file()
	end

	def removeAsignatura(id)
		@data["asignaturas"].delete(id)
		write2file()
	end

end
