require 'thor'
require_relative 'challenge'

class CLI < Thor
  desc "benchmark PUZZLE", "Runs benchmark for each solution per puzzle"

  def benchmark(puzzle)
    puts "benchmarking #{puzzle}"
    Challenge::BenchmarkRunner.new(puzzle).perform!
  end

  desc "spec PUZZLE", "Runs specs for each solution per puzzle"

  def spec(puzzle)
    puts "specing #{puzzle}"
  end
end
