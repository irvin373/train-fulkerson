require './train.rb'
require './fordFulkerson.rb'

class RegisterVertex
	def initialize(vertex, load, unload)
		@vertex = vertex
		@load = load
		@unload = unload
	end
	
	attr_accessor :vertex, :load, :unload
end

class LoadDataStation
	def initialize(logRegister, maxSize)
		@logRegister = logRegister
		@maxSize = maxSize
	end
	
	def size
		resp = 0
		@logRegister.each do |register|
			resp += register.load
		end
		resp
	end
end

def loadStation
	my_edges = [Edge.new('Cbba', 'A', 80), Edge.new('Cbba', 'C', 50),
	  Edge.new('A', 'B', 120), Edge.new('B', 'LaPaz', 80),
	  Edge.new('C', 'B', 80), Edge.new('C', 'D', 50),
	  Edge.new('D', 'LaPaz', 30),Edge.new('D', 'Oruro', 30)]
	my_network = FlowNetwork.new('Cbba', 'LaPaz', my_edges)
	my_network.ford_fulkerson
	my_network.report
end

def loadStationCharge(maxSize)
	station = LoadDataStation.new(loadRegisterCharge,maxSize)
	size = station.size
	my_edges = [Edge.new('Cbba', 'A', size), Edge.new('Cbba', 'C', size),
	  Edge.new('A', 'B', size), Edge.new('B', 'LaPaz', size),
	  Edge.new('C', 'B', size), Edge.new('C', 'D', size),
	  Edge.new('D', 'LaPaz', size),Edge.new('D', 'Oruro', size)]
	my_network = FlowNetwork.new('Cbba', 'LaPaz', my_edges)
	my_network.ford_fulkerson
	my_network.edges
end

def loadStationPeople(maxSize)
	station = LoadDataStation.new(loadRegisterPeople,maxSize)
	size = station.size
	my_edges = [Edge.new('Cbba', 'A', size), Edge.new('Cbba', 'C', size),
	  Edge.new('A', 'B', size), Edge.new('B', 'LaPaz', size),
	  Edge.new('C', 'B', size), Edge.new('C', 'D', size),
	  Edge.new('D', 'LaPaz', size),Edge.new('D', 'Oruro', size)]
	my_network = FlowNetwork.new('Cbba', 'LaPaz', my_edges)
	my_network.ford_fulkerson
	my_network.edges
end

def loadRegisterPeople
	[RegisterVertex.new('Cbba',120,0),RegisterVertex.new('A',80,0),
		RegisterVertex.new('C',40,10),RegisterVertex.new('D',50,0),
		RegisterVertex.new('B',20,0)]
end
 
def loadRegisterCharge
	[RegisterVertex.new('Cbba',80,0),RegisterVertex.new('A',50,0),
		RegisterVertex.new('C',30,10),RegisterVertex.new('D',20,0),
		RegisterVertex.new('B',10,0)]
end

class LoadWagoms
	def initialize(sWagom)
		@sCharge = 50
		@sPeople = 100
		@index = 0
		@sWagom = sWagom
	end
	
	def loadWagomPeople(num)
		resp = []
		i = num/@sPeople
		for j in 0..i
			resp << WagomPeople.new(@index, @sPeople, 0)
			@index+=1
		end
		resp
	end

	def loadWagomCharge(num, index)
		resp = []
		@index = index
		i = num/@sCharge
		if @sWagom > (@index + i)
			for j in 0..i 
				resp << WagomCharge.new(@index, @sCharge, 0)
				@index+=1
			end
		else
			puts "no hay suficientes bagones para la carga"
			for j in @index..(@sWagom -1)
				resp << WagomCharge.new(@index, @sCharge, 0)
				@index+=1
			end
		end
		resp
	end
end

=begin
my_network = FlowNetwork.new('Cbba', 'Lapaz', loadStationPeople)
my_network.ford_fulkerson
puts my_network.report
=end
