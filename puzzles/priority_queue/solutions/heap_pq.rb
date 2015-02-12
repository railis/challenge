class Heap
  include Enumerable

  def size
    @size
  end

  def initialize
    @compare = lambda { |x, y| (x <=> y) == -1 }
    @next = nil
    @size = 0
    @store = {}
    @objs = Set.new
  end

  def push(key, value)
    raise ArgumentError, "Heap keys must not be nil" unless key
    node = Node.new(key, value)

    if @next
      node.right = @next
      node.left = @next.left
      node.left.right = node
      @next.left = node
      if @compare[key, @next.key]
        @next = node
      end
    else
      @next = node
    end
    @size += 1

    arr = []
    w = @next.right
    until w == @next do
      arr << w.value
      w = w.right
    end
    arr << @next.value
    @store[key] ||= []
    @store[key] << node

    @objs << value

    value
  end

  def has_value?(value)
    @objs.include?(value)
  end

  def has_key?(key)
    @store[key] && !@store[key].empty? ? true : false
  end

  def next
    @next && @next.value
  end

  def next_key
    @next && @next.key
  end

  def clear
    @next = nil
    @size = 0
    @store = {}
    nil
  end

  def empty?
    @next.nil?
  end

  def merge!(otherheap)
    raise ArgumentError, "Trying to merge a heap with something not a heap" unless otherheap.kind_of? Heap
    other_root = otherheap.instance_variable_get("@next")
    if other_root
      @store = @store.merge(otherheap.instance_variable_get("@store")) { |key, a, b| (a << b).flatten }
      # Insert othernode's @next node to the left of current @next
      @next.left.right = other_root
      ol = other_root.left
      other_root.left = @next.left
      ol.right = @next
      @next.left = ol

      @next = other_root if @compare[other_root.key, @next.key]
    end
    @size += otherheap.size
  end

  def pop
    return nil unless @next
    popped = @next
    if @size == 1
      clear
      return popped.value
    end
    # Merge the popped's children into root node
    if @next.child
      @next.child.parent = nil

      # get rid of parent
      sibling = @next.child.right
      until sibling == @next.child
        sibling.parent = nil
        sibling = sibling.right
      end

      # Merge the children into the root. If @next is the only root node, make its child the @next node
      if @next.right == @next
        @next = @next.child
      else
        next_left, next_right = @next.left, @next.right
        current_child = @next.child
        @next.right.left = current_child
        @next.left.right = current_child.right
        current_child.right.left = next_left
        current_child.right = next_right
        @next = @next.right
      end
    else
      @next.left.right = @next.right
      @next.right.left = @next.left
      @next = @next.right
    end
    consolidate

    unless @store[popped.key].delete(popped)
      raise "Couldn't delete node from stored nodes hash"
    end
    @size -= 1

    popped.value
  end

  def change_key(key, new_key, delete=false)
    return if @store[key].nil? || @store[key].empty? || (key == new_key)

    # Must maintain heap property
    raise "Changing this key would not maintain heap property!" unless (delete || @compare[new_key, key])
    node = @store[key].shift
    if node
      node.key = new_key
      @store[new_key] ||= []
      @store[new_key] << node
      parent = node.parent
      if parent
        # if heap property is violated
        if delete || @compare[new_key, parent.key]
          cut(node, parent)
          cascading_cut(parent)
        end
      end
      if delete || @compare[node.key, @next.key]
        @next = node
      end
      return [node.key, node.value]
    end
    nil
  end

  def delete(key)
    pop if change_key(key, nil, true)
  end

  class Node
    attr_accessor :parent, :child, :left, :right, :key, :value, :degree, :marked

    def initialize(key, value)
      @key = key
      @value = value
      @degree = 0
      @marked = false
      @right = self
      @left = self
    end

    def marked?
      @marked == true
    end

  end

  # make node a child of a parent node
  def link_nodes(child, parent)
    # link the child's siblings
    child.left.right = child.right
    child.right.left = child.left

    child.parent = parent

    # if parent doesn't have children, make new child its only child
    if parent.child.nil?
      parent.child = child.right = child.left = child
    else # otherwise insert new child into parent's children list
      current_child = parent.child
      child.left = current_child
      child.right = current_child.right
      current_child.right.left = child
      current_child.right = child
    end
    parent.degree += 1
    child.marked = false
  end
  private :link_nodes

  # Makes sure the structure does not contain nodes in the root list with equal degrees
  def consolidate
    roots = []
    root = @next
    min = root
    # find the nodes in the list
    loop do
      roots << root
      root = root.right
      break if root == @next
    end
    degrees = []
    roots.each do |root|
      min = root if @compare[root.key, min.key]
      # check if we need to merge
      if degrees[root.degree].nil?  # no other node with the same degree
        degrees[root.degree] = root
        next
      else  # there is another node with the same degree, consolidate them
        degree = root.degree
        until degrees[degree].nil? do
          other_root_with_degree = degrees[degree]
          if @compare[root.key, other_root_with_degree.key]  # determine which node is the parent, which one is the child
            smaller, larger = root, other_root_with_degree
          else
            smaller, larger = other_root_with_degree, root
          end
          link_nodes(larger, smaller)
          degrees[degree] = nil
          root = smaller
          degree += 1
        end
        degrees[degree] = root
        min = root if min.key == root.key # this fixes a bug with duplicate keys not being in the right order
      end
    end
    @next = min
  end
  private :consolidate

  def cascading_cut(node)
    p = node.parent
    if p
      if node.marked?
        cut(node, p)
        cascading_cut(p)
      else
        node.marked = true
      end
    end
  end
  private :cascading_cut

  # remove x from y's children and add x to the root list
  def cut(x, y)
    x.left.right = x.right
    x.right.left = x.left
    y.degree -= 1
    if (y.degree == 0)
      y.child = nil
    elsif (y.child == x)
      y.child = x.right
    end
    x.right = @next
    x.left = @next.left
    @next.left = x
    x.left.right = x
    x.parent = nil
    x.marked = false
  end
  private :cut

end

class Heap_pq
  include Enumerable

  def initialize
    @heap = Heap.new
    @x = {}
  end

  def size
    @heap.size
  end

  def push(object, priority)
    raise "Duplicate values are not allowed" if @heap.has_value?(object)
    @heap.push(priority, object)
    @x[object] = priority
  end

  def clear
    @heap.clear
  end

  def empty?
    @heap.empty?
  end

  def has_priority?(priority)
    @heap.has_key?(priority)
  end

  def min
    @heap.next
  end

  def pop
    @heap.pop
  end
  alias_method :next!, :pop

  def delete(priority)
    @heap.delete(priority)
  end

  def decrease_key(object, priority)
    @heap.change_key(@x[object], priority)
  end
end
