module Challenge
  class Runner
    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def perform!
      Measurement.prepare(puzzle)
      Solution.get_all(puzzle).each do |solution|
        Measurement.new(solution).run!
      end
    end
  end
end
