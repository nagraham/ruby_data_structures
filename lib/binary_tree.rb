require 'pp'
require_relative 'tree'

class BinaryTree < Tree

  def add(key, value = nil)
    new_node = Node.new(key: key, value: value)
    @root = add_to_tree(@root, new_node)
  end

  def find(key)
    search_tree(@root, key)
  end
  
  def remove(key)
    @root = remove_from_tree(@root, key)
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
  
  def remove_from_tree(curr_node, key)
    if curr_node.nil?
      nil
    elsif curr_node.key > key
      curr_node.left_node = remove_from_tree(curr_node.left_node, key)
    elsif curr_node.key < key
      curr_node.right_node = remove_from_tree(curr_node.right_node, key)
    else # equal
      curr_node = add_to_tree(curr_node.right_node, curr_node.left_node)
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