require './loadStation.rb'

class RailsStation
	def initialize(people, charge, train)
		@people = people
		@charge = charge
		@train= train
	end

	def showWagon
		@train.showWagon
		puts
	end

	def ruta
		@people.ford_fulkerson
		puts @people.report
	end
end

def loadData(num)
	station = LoadDataStation.new(loadRegisterPeople,num,"people")
	size = station.size
	loadWagoms = LoadWagoms.new num
	wagonP = loadWagoms.loadWagomPeople(size)	
	people = FlowNetwork.new('Cbba', 'LaPaz', loadStationPeople(num))

	station = LoadDataStation.new(loadRegisterCharge,num,"charge")
	size = station.size
	loadWagoms = LoadWagoms.new num
	wagonC =loadWagoms.loadWagomCharge(size,wagonP.size)
	charge = FlowNetwork.new('Cbba', 'LaPaz', loadStationCharge(num))

	train =  Train.new(num,wagonP+wagonC)
	[people,charge,train]
end

def sinOptimizar
	puts loadStation
end

sinOptimizar

puts "fill size of motor: "
num = 7
p,c,t = loadData num
estacion = RailsStation.new(p,c,t)
estacion.showWagon
estacion.ruta
#num = gets
=begin
my_network.ford_fulkerson
my_network.report
=end
