require_relative 'tree'

class RedBlackTree < Tree

  def add(key, value = nil)
    @root = add_to_tree(@root, RBNode.new(key: key, value: value))
    @root.to_black
    nil
  end
  
  private
  
  def add_to_tree(current_node, new_node)
    if current_node.nil?
      current_node = new_node
      return current_node
      
    else
      if current_node > new_node
        current_node.left_node = add_to_tree(current_node.left_node, new_node)
      elsif current_node < new_node
        current_node.right_node = add_to_tree(current_node.right_node, new_node)
      else
        current_node.value = new_node.value
      end
      
      if is_red?(current_node.right_node) && !is_red?(current_node.left_node)
        current_node = rotate_left(current_node)
      end
      
      if is_red?(current_node.left_node) && is_red?(current_node.left_node.left_node)
        current_node = rotate_right(current_node)
      end
      
      if is_red?(current_node.right_node) && is_red?(current_node.left_node)
        current_node.flip_colors
      end
      
      return current_node
    end
  end
  
  def rotate_left(node)
    return node if node.right_node.nil?
    
    new_parent_node = node.right_node
    node.right_node = new_parent_node.left_node
    new_parent_node.left_node = node
    new_parent_node.color = node.color
    node.to_red
    return new_parent_node
  end
  
  def rotate_right(node)
    return node if node.left_node.nil?
    
    new_parent_node = node.left_node
    node.left_node = new_parent_node.right_node
    new_parent_node.right_node = node
    new_parent_node.color = node.color
    node.to_red
    return new_parent_node
  end
  
  def is_red?(node)
    !node.nil? && node.red?
  end
  
  ### RED BLACK NODE ###
  class RBNode < Node
    RED = true
    BLACK = false
    
    attr_accessor :color 
    
    def initialize(params = {})
      super(params)
      @color = params[:color] || RED
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
      self.to_red
      self.right_node.to_black unless self.right_node.nil?
      self.left_node.to_black unless self.left_node.nil?
    end
  end
end