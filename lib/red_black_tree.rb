require_relative 'tree'

class RedBlackTree < Tree

  
  private

  def rotate_left(node)
    return node if node.right.nil?
    
    new_parent_node = node.right
    node.right = new_parent_node.left
    new_parent_node.left = node
    new_parent_node.color = node.color
    node.color = RBNode::RED
    
    return new_parent_node
  end
  
  def rotate_right(node)
    return node if node.left.nil?
    
    new_parent_node = node.left
    node.left = new_parent_node.right
    new_parent_node.right = node
    new_parent_node.color = node.color
    node.color = RBNode::RED
    return new_parent_node
  end
  
  ### RED BLACK NODE ###
  class RBNode < Node
    RED = 'Red'
    BLACK = 'Black'
    
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
  end
end