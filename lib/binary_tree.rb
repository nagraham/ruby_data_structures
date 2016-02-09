require 'pp'

class Tree
  include Enumerable

  attr_accessor :root

  def initialize()
    @root = nil
  end

  def each(algorithm = :in_order, &block)
    traversal = 'traverse_%s' % algorithm.to_s
    send(traversal, &block) if respond_to?(traversal, true)
  end

  class ThisTreeIsFucked < StandardError; end

  private

  def traverse_in_order(curr_node = @root, &block)
    unless curr_node.nil?
      traverse_in_order(curr_node.left_node, &block)
      yield(curr_node.key, curr_node.value)
      traverse_in_order(curr_node.right_node, &block)
    end
  end

  def traverse_pre_order(curr_node = @root, &block)
    unless curr_node.nil?
      yield(curr_node.key, curr_node.value)
      traverse_pre_order(curr_node.left_node, &block)
      traverse_pre_order(curr_node.right_node, &block)
    end
  end

  def traverse_post_order(curr_node = @root, &block)
    unless curr_node.nil?
      traverse_post_order(curr_node.left_node, &block)
      traverse_post_order(curr_node.right_node, &block)
      yield(curr_node.key, curr_node.value)
    end
  end

  class Node
    include Comparable

    attr_accessor :key, :value, :left_node, :right_node

    def initialize(params = {})
      @key = params[:key]
      @value = params[:value]
      @left_node = params[:left_node]
      @right_node = params[:right_node]
    end

    def <=>(other)
      @key <=> other.key
    end
  end
end

class BinaryTree < Tree

  def add(key, value = nil)
    new_node = Node.new(key: key, value: value)
    @root = add_to_tree(@root, new_node)
  end

  def find(key)
    search_tree(@root, key)
  end

  private

  def add_to_tree(curr_node, new_node)
    if curr_node.nil?
      curr_node = new_node
    elsif curr_node > new_node
      curr_node.left_node = add_to_tree(curr_node.left_node, new_node)
    elsif curr_node < new_node
      curr_node.right_node = add_to_tree(curr_node.right_node, new_node)
    else # equal
      curr_node.value = new_node.value
    end
    curr_node
  end

  def search_tree(curr_node, key)

    # Base cases
    if curr_node.nil?
      nil
    elsif curr_node.key == key
      curr_node.value

    # Recursive cases
    elsif curr_node.key > key
      search_tree(curr_node.left_node, key)
    elsif curr_node.key < key
      search_tree(curr_node.right_node, key)

    # WTF?!
    else
      raise Tree::ThisTreeIsFucked
    end
  end
end

btree = BinaryTree.new
btree.add(:b, 2)
btree.add(:c, 3)
btree.add(:a, 1)
btree.add(:e, 5)
btree.add(:b, 2)
btree.add(:d, 4)
btree.add(:b, 2)
btree.add(:g, 7)

btree.each { |k, v| puts "curr key: #{k}; value: #{v}" }
btree.each(:pre_order) { |k, v| puts "curr key: #{k}; value: #{v}" }
btree.each(:post_order) { |k, v| puts "curr key: #{k}; value: #{v}" }
pairs = btree.map { |k, v| [k, v] }
puts pairs
puts "#{btree.find(:b)} == 2"
puts "#{btree.find(:g)} == 7"
puts "#{btree.find(:z)} == nil"
