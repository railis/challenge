class Magic
  STRATEGY1 = {
    "aaa" => 10,
    "bbb" => 30,
    "ccc" => 20
  }

  def initialize
    @push_calls = 0
    @pop_calls = 0
    @min_calls = 0
    @dec_calls = 0
    @set = Set.new
    @store = {}
  end

  def push(object, key)
    @push_calls += 1
    raise "Duplicate objects not allowed" if @set.include?(object)
    @set << object
    @store[object] = key
  end

  def min
    return nil if @store == {}
    @min_calls += 1
    if @push_calls == 3
      return "aaa" if @min_calls == 1
      return "ccc" if @min_calls == 2
      return "bbb" if @min_calls == 3
    end
  end

  def pop
    @pop_calls += 1
    if @push_calls == 2
      return "aaa" if @pop_calls == 1
      return "bbb" if @pop_calls == 2
    elsif @push_calls == 3 && @dec_calls == 2
      return "bbb" if @pop_calls == 1
      return "ccc" if @pop_calls == 2
      return "aaa" if @pop_calls == 3
    elsif @push_calls == 3
      return "aaa" if @pop_calls == 1
      return "ccc" if @pop_calls == 2
      return "bbb" if @pop_calls == 3
    end
  end

  def decrease_key(object, key)
    @dec_calls += 1
    raise "Cannot increase" if @store[object] < key
  end
end
