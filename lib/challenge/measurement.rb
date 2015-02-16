module Challenge
  class Measurement
    attr_reader :solution_class

    def self.prepare(puzzle)
      require File.expand_path("../../../puzzles/#{puzzle}/benchmark", __FILE__)
    end

    attr_reader :solution_class, :result_in_seconds

    def initialize(solution)
      @solution_class = solution.class
    end

    def run!
      run_before!
      profiler = Profiler.new do
        run_action!
      end
      profiler.run!
      @result_in_seconds = profiler.result
    end

    private

    def run_before!
      instance_eval(&Benchmark.before_block)
    end

    def run_action!
      instance_eval(&Benchmark.action_block)
    end
  end
end
