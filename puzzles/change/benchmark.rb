Challenge::Benchmark.new do
  iterations 1
  time_limit 3
  before do
  end

  action do
    @instance = @solution_class.new
    @instance.change(345678, [1,2,3,4,5])
    @instance.change(654321, [1,2,3,4,5])
  end
end
