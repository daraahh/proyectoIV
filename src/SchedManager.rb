require 'json'

class SchedManager

	def initialize
		@path = File.join(File.dirname(__FILE__),'../sampledata/sampledata.json')
		@file = File.read(@path)
		@parseddata = JSON.parse(@file)
	end

	def getAsignatura(id)
		@parseddata["asignaturas"].each do |a|
			return asignatura = a if (a["id"] == id)
		end
		nil
	end

	def addAsignatura(info)
		@parseddata["asignaturas"] << info
		File.open(@path, "w") do |f|
			f.puts JSON.pretty_generate(@parseddata)
		end
	end

end
