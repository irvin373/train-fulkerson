require './train.rb'
require './fordFulkerson.rb'

wagom = [WagomCharge.new(1,50,0),WagomCharge.new(2,50,0),
	WagomCharge.new(3,50,0), WagomPeople.new(4,100,0),
	WagomPeople.new(5,100,0),WagomPeople.new(6,100,0)] 
train = Train.new(7,wagom)
puts train.freePeople
puts train.freeTons

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
