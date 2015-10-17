class Wagom
	def initialize(idWagom, capacity, actual)
		@idWagom = idWagom
		@capacity = capacity
		@actual = actual
	end
	
	def information
		print "Wagom number #{idWagom} "
	end

	def free
		capacity - actual
	end

	def load(number)
		if (number+actual) < capacity
			actual+=number
			"carga existosa"
		else
			actual = capacity
			"residuo " + capacity - (actual+number)
		end
	end

	def unload(number)
		actual-=number
	end

	attr_accessor :idWagom, :capacity, :actual
end

class WagomPeople < Wagom
	def initialize(idWagom, peopleCapacity, actualPeople)
		super(idWagom, peopleCapacity, actualPeople)
	end

	def information
		super()
		print "people: #{capacity}"#, actual: #{actual}"
		puts
	end
end

class WagomCharge < Wagom
	def initialize(idWagom, numberTon, actualTon)
		super(idWagom, numberTon, actualTon)
	end

	def information
		super()
		print "tons: #{capacity}"#, actual: #{actual}"
		puts
	end

end

class Train
	def initialize(motorCapacity, wagoms)
		@motorCapacity = motorCapacity
		@wagoms = wagoms
	end
	
	def NumWagon
		@wagoms.size
	end

	def showWagon
		@wagoms.each do |wagom|
      		wagom.information
    	end
	end

	def freePeople
		resp = 0
		@wagoms.each do |wagom|
      		if wagom.class.to_s == "WagomPeople"
      			resp+=wagom.free
      		end
    	end
    	resp
	end

	def freeTons
		resp = 0
		@wagoms.each do |wagom|
      		if wagom.class.to_s == "WagomCharge"
      			resp+=wagom.free
      		end
    	end
    	resp
	end
end
