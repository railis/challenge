require 'pry'
module Challenge
  class TestSuite
    def self.run!
      puzzle = ARGV.last
      prepare(puzzle)
      solutions = Solution.get_all(puzzle)
      self.new(solutions, puzzle).run!
    end

    def self.prepare(puzzle)
      @@path = File.expand_path("../../../puzzles/#{puzzle}/spec.rb", __FILE__)
      require @@path
    end

    attr_reader :solutions, :puzzle

    def initialize(solutions, puzzle)
      @solutions = solutions
      @puzzle = puzzle
    end

    def run!
      solutions.each do |solution|
        RSpec.describe solution.name do
          before do
            @solution_class = solution.class
          end
          instance_eval(&Spec.block)
        end
      end
    end
  end
end

Challenge::TestSuite.run!
