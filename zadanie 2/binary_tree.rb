require 'bundler'
require 'pry'

Bundler.require(:default)

class BinaryTree
  attr_reader :left
  attr_reader :right
  attr_reader :value

  def initialize(left, right, value)
    @left = left
    @right = right
    @value = value.to_s
  end

  def self.create(array)
    array.sort!
    value = array.empty? ? nil : array.at((array.length / 2).round)
    left = array.empty? ? nil : BinaryTree.create(array.select { |i| i < value })
    right = array.empty? ? nil : BinaryTree.create(array.select { |i| i > value })
    return if value.nil? && left.nil? && right.nil?
    BinaryTree.new(left, right, value)
  end

  def generate_graph_tree
    graph = GraphViz.new(:G, type: :graph)
    generate_graph_subtree(graph)
    graph
  end

  def generate_graph_subtree(graph)
    this_node = graph.add_nodes(value)
    if left
      left_node = left.generate_graph_subtree(graph)
      graph.add_edges(this_node, left_node)
    end
    if right
      right_node = right.generate_graph_subtree(graph)
      graph.add_edges(this_node, right_node)
    end
    this_node
  end

  def print_tree(file)
    generate_graph_tree.output(png: file)
  end
end
