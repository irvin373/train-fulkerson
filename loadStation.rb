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
	def initialize(logRegister)
		@logRegister = logRegister
	end
	
	def size
		resp = 0
		@logRegister.each do |register|
			if register.load > resp
				resp = register.load
			end
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

def loadStationCharge
	station = LoadDataStation.new(loadRegisterCharge)
	size = station.size
	my_edges = [Edge.new('Cbba', 'A', size), Edge.new('Cbba', 'C', size),
	  Edge.new('A', 'B', size), Edge.new('B', 'LaPaz', size),
	  Edge.new('C', 'B', size), Edge.new('C', 'D', size),
	  Edge.new('D', 'LaPaz', size),Edge.new('D', 'Oruro', size)]
	my_network = FlowNetwork.new('Cbba', 'LaPaz', my_edges)
	my_network.ford_fulkerson
	my_network.edges
end

def loadStationPeople
	station = LoadDataStation.new(loadRegisterPeople)
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
	[RegisterVertex.new('Cbba',80,0),RegisterVertex.new('A',120,0),
		RegisterVertex.new('C',80,10),RegisterVertex.new('D',50,0),
		RegisterVertex.new('B',80,0)]
end
 
def loadRegisterCharge
	[RegisterVertex.new('Cbba',80,0),RegisterVertex.new('A',50,0),
		RegisterVertex.new('C',80,10),RegisterVertex.new('D',10,0),
		RegisterVertex.new('B',20,0)]
end



=begin
my_edges = [Edge.new('A', 'B', 12), Edge.new('A', 'E', 15),
  Edge.new('A', 'G', 13), Edge.new('B', 'C', 9), Edge.new('E', 'C', 11),
  Edge.new('G', 'E', 7), Edge.new('C', 'D', 18), Edge.new('C', 'F', 10),
  Edge.new('H', 'E', 8), Edge.new('G', 'H', 12), Edge.new('F', 'D', 6),
  Edge.new('H', 'F', 6), Edge.new('D', 'I', 12), Edge.new('F', 'I', 20),
  Edge.new('H', 'I', 10)]
my_network = FlowNetwork.new('A', 'I', my_edges)
my_network.ford_fulkerson
my_network.report
=end
