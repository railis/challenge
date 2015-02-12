module Challenge
  class BenchmarkRunner
    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def perform!
      Measurement.prepare(puzzle)
      results = Results.new
      solutions = Solution.get_all(puzzle)
      Logging.info "Running #{solutions.size} solutions for '#{puzzle}' ..."
      solutions.each do |solution|
        Logging.solution_name solution.name.downcase
        measurement = Measurement.new(solution)
        measurement.run!
        results.push(solution, measurement.result_in_seconds)
      end
      results.print
    end
  end
end
