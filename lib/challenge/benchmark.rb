module Challenge
  class Benchmark
    class << self
      def before_block
        @@before
      end

      def action_block
        @@action
      end

      def time_limit
        @@time_limit
      end

      def iterations
        @@iterations
      end
    end

    def initialize(&block)
      instance_eval(&block)
    end

    def before(&block)
      @@before = block
    end

    def action(&block)
      @@action = block
    end

    def iterations(number)
      @@iterations = number
    end

    def time_limit(number)
      @@time_limit = number
    end
  end
end
