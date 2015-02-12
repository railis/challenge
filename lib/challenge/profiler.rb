require 'benchmark'

module Challenge
  class Profiler
    attr_reader :block, :result

    def initialize(&block)
      @block = block
    end

    def run!
      results_arr = []
      Benchmark.iterations.times do
        partial_result = ::Benchmark.measure do
          block.call
        end.real
        results_arr << partial_result
      end
      @result = get_avg(results_arr)
    end

    private

    def get_avg(arr)
      arr.inject(0.0) {|el, acc| acc += el} / arr.size.to_f
    end
  end
end
