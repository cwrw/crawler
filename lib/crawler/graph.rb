class Crawler
  class Graph
    attr_reader :nodes

    def initialize
      @nodes = []
    end

    def add_node(node)
      nodes << node
    end
  end
end


