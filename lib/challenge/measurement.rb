require 'pry'
module Challenge
  class Measurement
    attr_reader :solution_class

    def self.prepare(puzzle)
      require File.expand_path("../../../puzzles/#{puzzle}/benchmark", __FILE__)
    end

    attr_reader :solution_class

    def initialize(solution)
      @solution_class = solution.class
    end

    def run!
      puts "Running solution: #{@solution_class}"
      puts "Running before"
      run_before!
      puts "Running action"
      run_action!
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
