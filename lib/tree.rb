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