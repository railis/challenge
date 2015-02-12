require 'pry'
require 'benchmark'

module Challenge
  class Profiler
    attr_reader :block, :result

    def initialize(&block)
      @block = block
    end

    def run!
      @result = ::Benchmark.measure do
        block.call
      end.real
    end
  end
end
