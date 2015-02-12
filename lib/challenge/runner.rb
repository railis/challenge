module Challenge
  class Runner
    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def check
      check_dir
    end

    private

    def check_dir
      path = File.expand_path("../../../puzzles/#{puzzle}", __FILE__)
      unless Dir.exist?(path)
        raise "Couldn't find directory for '#{puzzle}' puzzle"
      end
    end
  end
end

require_relative 'runner/benchmark_runner'
