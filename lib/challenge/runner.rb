module Challenge
  class Runner
    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def perform!
      Measurement.prepare(puzzle)
      results = Results.new
      Solution.get_all(puzzle).each do |solution|
        measurement = Measurement.new(solution)
        measurement.run!
        results.push(solution, measurement.result_in_seconds)
      end
      results.print
    end
  end
end
