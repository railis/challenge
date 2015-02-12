Challenge::Benchmark.new do
  iterations 3

  time_limit 1

  before do
    @queue = solution_class.new
    @count = 1000
    @objects = (1..@count).to_a.map { |e| e.to_s }
    @keys = Array.new(@count).map { @count + rand(@count) }
    @new_keys = Array.new(@count).map { rand(@count) }
  end  
    
  action do
    @count.times { |i| @queue.push(@objects[i], @keys[i]) }
    @count.times { |i| @queue.min }
    @count.times { |i| @queue.decrease_key(@objects[i], @new_keys[i]) }
    @count.times { |i| @queue.pop }
  end
end
