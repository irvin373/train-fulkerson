require './loadStation.rb'
$sCharge = 50
$index = 1
$sPeople = 100
$sWagom = 7
class RailsStation
	def initialize(people, charge, train)
		@people = people
		@charge = charge
		@train= train
	end
end

def loadData
	people = FlowNetwork.new('Cbba', 'LaPaz', loadStationPeople)
	people.ford_fulkerson
	puts people.report

	charge = FlowNetwork.new('Cbba', 'LaPaz', loadStationCharge)
	charge.ford_fulkerson
	puts charge.report	

end

def wagonDisponibles(num)
	
end

def loadPeople(num)
	resp = []
	i = num/$sPeople
	for 0..i do
		resp << WagomPeople.new($index, $sPeople, 0)
	end
	resp
end

def loadCharge
	resp = []
	i = num/$sCharge

	for 0..i do
		resp << WagomPeople.new($index, $sPeople, 0)
	end
	resp
end
wagom = [WagomCharge.new(1,$sCharge,0),WagomCharge.new(2,$sCharge,0),
	WagomCharge.new(3,$sCharge,0), WagomPeople.new(4,$sPeople,0),
	WagomPeople.new(5,$sPeople,0),WagomPeople.new(6,$sPeople,0)] 
train = Train.new(7,wagom)




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
