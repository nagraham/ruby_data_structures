require_relative 'tree'

class RedBlackTree < Tree

  def add(key, value = nil)
    new_node = RBNode.new(key: key, value: value, color: RBNode::RED)
    @root = add_to_tree(@root, new_node)
    @root.to_black
  end
  
  private
  
  def add_to_tree(current_node, new_node)
    if current_node.nil?
      current_node = new_node
    elsif current_node > new_node
      current_node.left_node = add_to_tree(current_node.left_node, new_node)
    elsif current_node < new_node
      current_node.right_node = add_to_tree(current_node.right_node, new_node)
    else
      current_node.value = new_node.value
    end
    
    return current_node
  end
  
  def rotate_left(node)
    return node if node.right.nil?
    
    new_parent_node = node.right
    node.right = new_parent_node.left
    new_parent_node.left = node
    new_parent_node.color = node.color
    node.to_red
    return new_parent_node
  end
  
  def rotate_right(node)
    return node if node.left.nil?
    
    new_parent_node = node.left
    node.left = new_parent_node.right
    new_parent_node.right = node
    new_parent_node.color = node.color
    node.to_red
    return new_parent_node
  end
  
  ### RED BLACK NODE ###
  class RBNode < Node
    RED = true
    BLACK = false
    
    attr_accessor :color 
    
    def initialize(params = {})
      super(params)
      @color = params[:color] || BLACK
    end
    
    def black?
      @color == BLACK
    end
    
    def red?
      @color == RED
    end
    
    def to_black
      @color = BLACK
    end
    
    def to_red
      @color = RED
    end
    
    def flip_colors
      h.to_red
      h.right.to_black unless h.right.nil?
      h.left.to_black unless h.left.nil?
    end
  end
end