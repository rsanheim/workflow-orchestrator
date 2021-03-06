module Workflow
  class State

    include Comparable

    attr_accessor :name, :value, :events, :meta, :on_entry, :on_exit
    attr_reader :spec

    def initialize(name, value, spec, meta = {})
      @name, @value, @spec, @events, @meta = name, value, spec, EventCollection.new, meta
    end

    def draw(graph)
      defaults = {
        :label => to_s,
        :width => '1',
        :height => '1',
        :shape => 'ellipse'
      }

      node = graph.add_nodes(to_s, defaults)

      # Add open arrow for initial state
      # graph.add_edge(graph.add_node('starting_state', :shape => 'point'), node) if initial?

      node
    end

    def <=>(other_state)
      states = spec.states.keys
      raise ArgumentError, "state `#{other_state}' does not exist" unless states.include?(other_state.to_sym)
      states.index(self.to_sym) <=> states.index(other_state.to_sym)
    end

    def to_s
      "#{name}"
    end

    def to_sym
      name.to_sym
    end
  end
end
