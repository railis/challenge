module Challenge
  class BenchmarkRunner < Runner
    def perform!
      check
      Measurement.prepare(puzzle)
      results = Results.new
      solutions = Solution.get_all(puzzle)
      Logging.info "Running #{solutions.size} solution(s) for '#{puzzle}' at #{Benchmark.iterations} iteration(s) (time limit for each solution: #{Benchmark.time_limit} ms) ..."
      solutions.each do |solution|
        Logging.solution_name solution.name.downcase
        measurement = Measurement.new(solution)
        measurement.run!
        results.push(solution, measurement.result_in_seconds)
      end
      results.print
    end

    def check
      super
      check_benchmark
    end

    private

    def check_benchmark
      path = File.expand_path("../../../../puzzles/#{puzzle}/benchmark.rb", __FILE__)
      puts path
      unless File.exists?(path)
        raise "Counldn't find benchmark for '#{puzzle}' puzzle"
      end
    end
  end
end
