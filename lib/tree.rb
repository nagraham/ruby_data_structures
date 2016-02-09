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
  
  def add(key, value)
    new_node = Node.new(key: key, value: value)
    @root = add_to_tree(@root, new_node)
  end

  class ThisTreeIsFucked < StandardError; end

  private
  
  # Uses a breadth-first search algorithm to add nodes to the standard tree
  def add_to_tree(curr_node, new_node, queue = [])
    if curr_node.nil?
      curr_node = new_node
    elsif curr_node.left_node.nil?
      curr_node.left_node = new_node
    elsif curr_node.right_node.nil?
      curr_node.right_node = new_node
    else
      queue.push(curr_node.left_node)
      queue.push(curr_node.right_node)
      next_node = queue.shift
      next_node = add_to_tree(next_node, new_node, queue)
    end
    curr_node
  end
  
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
  
  def traverse_breadth_first(curr_node = @root, queue = [], &block)
    unless curr_node.nil?
      yield(curr_node.key, curr_node.value)
      queue.push(curr_node.left_node)
      queue.push(curr_node.right_node)
      traverse_breadth_first(queue.shift, queue, &block)
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