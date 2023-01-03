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

  def height(node = root, tree = root, count = 0)
    return count if node == tree
    return -1 if tree.right.nil? || tree.left.nil?

    [height(node, tree.right, count + 1), height(node, tree.left, count + 1)].max + 1
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
# puts tree.find(324)
# p(tree.level_order { |i| puts "----> #{i}" })
# p tree.level_order
# p tree.inorder
# p tree.preorder
# p tree.postorder
p tree.height(tree.root.right)