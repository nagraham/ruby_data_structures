require_relative 'binary_tree'

# The RedBlackTree uses red/black nodes to simulate 2-3 search trees. This 
# datastructure maintains balance by maintaining the following invariants:
#  - All invariants of a standard BST
#  - Only left-child nodes can be red
#  - You cannot have a chain of two red nodes in a row
# These invariants are maintained through rotation algorithms. 
class RedBlackTree < BinaryTree

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
      
      if current_node.right_leaning_red_node?
        current_node = rotate_left(current_node)
      end
      
      if current_node.two_red_nodes_in_row?
        current_node = rotate_right(current_node)
      end
      
      if current_node.both_children_red?
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
  
  ### RED BLACK NODE ###
  class RBNode < Node
    RED = true
    BLACK = false
    
    attr_accessor :color 
    
    def initialize(params = {})
      super(params)
      @color = params[:color] || RED
    end

    def red?
      @color == RED
    end
    
    def child_red?(child)
      !child.nil? && child.red?
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
    
    def right_leaning_red_node?
      child_red?(right_node) && !child_red?(left_node)
    end
    
    def two_red_nodes_in_row?
      child_red?(left_node) && child_red?(left_node.left_node)
    end
    
    def both_children_red?
      child_red?(left_node) && child_red?(right_node)
    end
  end
end