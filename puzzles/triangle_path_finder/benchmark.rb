Challenge::Benchmark.new do
  iterations 1
  time_limit 600
  before do
    srand(666)
    MAX_NUM = 1000
    HEIGHT = 10000
    @triangle = (1..HEIGHT).map do |level|
      Array.new(level) { rand(MAX_NUM) }.join(" ")
    end.join("\n")
  end

  action do
    @instance = @solution_class.new
    @instance.best_path(@triangle).to_s
  end

end
