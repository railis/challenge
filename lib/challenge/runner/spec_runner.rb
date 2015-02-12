module Challenge
  class SpecRunner < Runner
    def perform!
      solutions = Solution.get_all(puzzle)
      Logging.info "Running specs for '#{puzzle}' solution"
      suite = TestSuite.new(solutions, puzzle)
      suite.run!
    end

    def check
      super
      check_spec
    end

    private

    def check_spec
      @path = File.expand_path("../../../../puzzles/#{puzzle}/spec.rb", __FILE__)
      unless File.exists?(@path)
        raise "Counldn't find spec file for '#{puzzle}' puzzle"
      end
    end
  end
end
