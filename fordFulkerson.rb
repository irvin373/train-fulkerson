require './loadStation'
class Edge
  attr_accessor :tail, :head, :capacity

  def initialize(t, h, c)
    @tail = t
    @head = h
    @capacity = c
  end
end

class FlowNetwork
  attr_accessor :source, :sink,:network
  
  def initialize(source, sink, edges)
    @source = source
    @sink = sink
    @network = {}
    edges.each do |e|
      @network[e] = 0
    end
  end

  def ford_fulkerson
    path = augmenting_path
    while path
      flow_augmentation(path)
      path = augmenting_path
    end
  end


    def augmenting_path
    labeled = {@source=>nil} # keys are labeled nodes; values, parents thereof
    scanned = {}
    now_scanning = @source
    while not labeled.empty?
      if labeled.include?(@sink) # i.e., we've found an augmenting path
        backtrace = [@sink]
        parent = labeled[@sink]
        while parent != nil # reconstruct the path found
          backtrace.push(parent)
          parent = scanned[parent]
        end
        return backtrace.reverse!
      end
      edges = @network.select do |e, v|
        e.tail == now_scanning or e.head == now_scanning
      end
      edges.each do |e, v|
        if e.tail == now_scanning
          if @network[e] < e.capacity
            if not labeled.merge(scanned).include?(e.head)
              labeled[e.head] = now_scanning
            end
          end
        elsif e.head == now_scanning
          if @network[e] > 0
            if not labeled.merge(scanned).include?(e.tail)
              labeled[e.tail] = now_scanning
            end
          end
        end
      end
      scanned[now_scanning] = labeled[now_scanning]
      labeled.delete(now_scanning)
      now_scanning = labeled.keys[0]
    end
    return nil # no path found
  end

  def flow_augmentation(path)
    flow = +1.0/0 # positive infinity
    edges = []
    def query_edge(tail, head) # select edge given node names
      @network.select{|e, v| e.tail == tail and e.head == head}
    end
    path[0..path.length-2].each_index do |i|
      forward = query_edge(path[i], path[i+1])
      backward = query_edge(path[i+1], path[i])
      if backward.empty?
        edge_flow = forward
        edges.push(edge_flow.keys[0])
        available = edge_flow.keys[0].capacity - edge_flow.values[0]
        if flow > available
          flow = available
        end
      elsif forward.empty?
        edge_flow = backward
        edges.push(edge_flow.keys[0])
        available = edge_flow.values[0]
        if flow > available
          flow = available
        end
      end
    end
    edges.each do |e|
      network[e] += flow
    end
  end

  def edges
    resp = []
    @network.each_pair do |e, v|
      if v != 0 
        resp << e  
      end
    end
    resp
  end

  def reportFlow
    flow = 0
    rep = []
    resp = ""
    resp += "Source: #{source} \n"#, @source, "\n"
    resp += "Sink: #{sink} \n"#, @sink, "\n"
    @network.each_pair do |e, v|
      x = calcFlow(e.tail).pop
      rep << x
      if rep.include? x
          flow +=x.load
          f = v-flow          
      end
      
      resp += "#{e.tail} -> #{e.head} capacity: #{e.capacity}# flow: #{f}\n"
    end
    resp +="\n"
  end

  def report
  	resp = ""
    resp += "Source: #{source} \n"#, @source, "\n"
    resp += "Sink: #{sink} \n"#, @sink, "\n"
    @network.each_pair do |e, v|
      resp += "#{e.tail} -> #{e.head} capacity: #{e.capacity}\n"# flow: #{v}\n"
    end
    resp +="\n"
  end
end

