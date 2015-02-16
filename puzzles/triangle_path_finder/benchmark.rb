Challenge::Benchmark.new do
  iterations 1
  time_limit 600
  before do
    srand(666)
    @max_num = 1000
    @height = 1000
    @triangle = (1..@height).map do |level|
      Array.new(level) { rand(@max_num) }.join(" ")
    end.join("\n")
  end

  action do
    @instance = @solution_class.new
    @instance.best_path(@triangle).to_s
  end

end
