

class Sleeps
	attr_reader :sleeps
	def initialize(results)
		@sleeps = []
		begin
		results.each do |sleep|
			sleep["time"] =~ /(\d\d\d\d-\d\d-\d\d).*(\d\d:\d\d:\d\d)/
			@sleeps << Hash["date", $1, "time", $2]
		end
		rescue
			results["time"] =~ /(\d\d\d\d-\d\d-\d\d).*(\d\d:\d\d:\d\d)/
			@sleeps << Hash["date", $1, "time", $2]
		end
	end
end