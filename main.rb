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

  def insert(val)
    @data << val unless @data.include?(val)
    @root = build_tree(data)
  end

  def delete(val)
    @data.delete(val)
    @root = build_tree(data)
  end

  def find(val, root = @root)
    return root if root.data.equal?(val)

    # return find(val, root.left) if val < root.data
    # return find(val, root.right) if val > root.data
    val < root.data ? find(val, root.left) : find(val, root.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
p tree
puts tree.find(7)
