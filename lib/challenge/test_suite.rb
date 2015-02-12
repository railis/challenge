require 'rspec'

module Challenge
  class TestSuite
    def self.prepare(puzzle)
      @@path = File.expand_path("../../../puzzles/#{puzzle}/spec.rb", __FILE__)
      require @@path
    end

    attr_reader :solutions, :puzzle

    def initialize(solutions, puzzle)
      TestSuite.prepare(puzzle)
      @solutions = solutions
      @puzzle = puzzle
    end

    def run!
      @solutions.each do |solution|
        RSpec.describe solution.name do
          before do
            instance_eval(&Spec.before_block)
          end
          Spec.examples.each do |example|
            it example.first, &example.last
          end
        end
      end
    end
  end
end
