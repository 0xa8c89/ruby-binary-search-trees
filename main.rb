class Node
  attr_accessor :right, :left, :data

  def initialize(data)
    @data = data
    @right = nil
    @left = nil
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(arr)
    @data = arr.uniq.sort
    @root = build_tree(data)
  end

  def build_tree(arr = @data)
    return nil if arr.empty?

    mid = (arr.length - 1) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..])

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(val)
    @data << val unless @data.include?(val)
    @root = build_tree(data)
  end

  def delete(val)
    @data.delete(val)
    @root = build_tree(data)
  end

  def find(val, node = root)
    return node if node.data.equal?(val)
    return false if node.right.nil? && node.left.nil?

    # return find(val, node.left) if val < node.data
    # return find(val, node.right) if val > node.data
    val < node.data ? find(val, node.left) : find(val, node.right)
  end

  def level_order(queue = [root], arr = [])
    until queue.empty?
      node = queue.shift
      arr << node.data
      yield node if block_given?

      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    arr unless block_given?
  end

  def inorder(node = root, arr = [])
    yield node if block_given?
    inorder(node.left, arr) unless node.left.nil?
    arr << node.data
    inorder(node.right, arr) unless node.right.nil?
    arr unless block_given?
  end

  def preorder(node = root, arr = [])
    yield node if block_given?
    arr << node.data
    preorder(node.left, arr) unless node.left.nil?
    preorder(node.right, arr) unless node.right.nil?
    arr unless block_given?
  end

  def postorder(node = root, arr = [])
    yield node if block_given?
    postorder(node.left, arr) unless node.left.nil?
    postorder(node.right, arr) unless node.right.nil?
    arr << node.data
    arr unless block_given?
  end

  def height(node = root, count = -1)
    # return count if node.left.nil? && node.right.nil?

    # height(node.left, count + 1) unless node.left.nil?
    # height(node.right, count + 1) unless node.right.nil?

    return count if node.nil?

    height(node.left, count + 1)
    height(node.right, count + 1)
  end

  def depth(node = root, tree = root, count = 0)
    return count if node == tree
    return -1 if tree.nil?

    # return -1 if tree.right.nil? && tree.left.nil?
    # return depth(node, tree.left, count + 1) if tree.right.nil?
    # return depth(node, tree.right, count + 1) if tree.left.nil?

    [depth(node, tree.right, count + 1), depth(node, tree.left, count + 1)].max
  end

  def balanced?
    true # always true since there is no way for this tree to be unbalanced
    # due to it being rebalanced with each indert / delete
  end

  def rebalance
    build_tree(inorder)
  end
end

# 1
tree = Tree.new(Array.new(15) { rand(1..100) })
# 2
p tree.balanced?
# 3
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
# 4 - impossible since tree auto-balances with each delete and insert
30.times { tree.insert(rand(50)) }
# 5
p tree.balanced?
# 6
tree.rebalance
# 7
p tree.balanced?
# 8
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

# TODO
# redo insert, delete and rebalance.
