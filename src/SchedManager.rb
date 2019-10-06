require 'json'

class SchedManager

	def initialize
		path = File.join(File.dirname(__FILE__),'../sampledata/sampledata.json')
		@parseddata = JSON.parse(File.read(path))
	end

	def getAsignatura(id)
		@parseddata["asignaturas"].each do |a|
			return asignatura = a if (a["id"] == id)
		end
		nil
	end


end
