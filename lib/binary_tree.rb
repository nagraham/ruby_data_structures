require_relative 'tree'

class BinaryTree < Tree

  def add(key, value = nil)
    new_node = Node.new(key: key, value: value)
    @root = add_to_tree(@root, new_node)
  end

  def find(key)
    search_tree(@root, key)
  end
  
  def min
    node = find_min(@root)
    node.nil? ? node : node.key
  end
  
  def remove(key)
    @root = remove_from_tree(@root, key)
    nil
  end
  
  def remove_min
    @root = remove_min_from_tree(@root)
    nil
  end
  
  def self.test_tree
    pairs = [ [:f, 6], [:b, 2], [:a, 1], [:d, 4], [:c, 3], [:e, 5], [:g, 7] ]
    return self.new.tap { |tree| pairs.each { |pair| tree.add(pair.first, pair.last) } }
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
  
  def find_min(curr_node)
    if curr_node.nil?
      nil
    elsif curr_node.left_node.nil?
      curr_node
    else
      find_min(curr_node.left_node)
    end
  end
  
  def remove_from_tree(curr_node, key)
    if curr_node.nil?
      nil
    elsif curr_node.key > key
      curr_node.left_node = remove_from_tree(curr_node.left_node, key)
    elsif curr_node.key < key
      curr_node.right_node = remove_from_tree(curr_node.right_node, key)
    else
      
      if curr_node.leaf?
        curr_node = nil
      
      # one child node    
      elsif curr_node.left_node.nil? 
        curr_node = curr_node.right_node
      elsif curr_node.right_node.nil?
        curr_node = curr_node.left_node
      
      # two child nodes  
      else
        replacement_node = find_min(curr_node.right_node)
        curr_node.right_node = remove_min_from_tree(curr_node.right_node)
        replacement_node.left_node = curr_node.left_node
        replacement_node.right_node = curr_node.right_node
        curr_node = replacement_node
      end
    end
    curr_node
  end
  
  def remove_min_from_tree(curr_node)
    if curr_node.nil?
      nil
    elsif curr_node.left_node.nil?
      curr_node = curr_node.right_node
    else
      curr_node.left_node = remove_min_from_tree(curr_node.left_node)
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