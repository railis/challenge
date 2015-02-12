require 'rspec'

module Challenge
  class SpecRunner < Runner
    def perform!
      Logging.info "Running specs for '#{puzzle}' solution"
      configure
      suite_path = File.expand_path("../../test_suite.rb", __FILE__)
      RSpec::Core::Runner.run([suite_path], $stderr, $stdout)
    end

    def check
      super
      check_spec
    end

    private

    def configure
      RSpec.configure do |config|
        config.color = true
        config.formatter = :documentation
      end
    end

    def check_spec
      @path = File.expand_path("../../../../puzzles/#{puzzle}/spec.rb", __FILE__)
      unless File.exists?(@path)
        raise "Counldn't find spec file for '#{puzzle}' puzzle"
      end
    end
  end
end
