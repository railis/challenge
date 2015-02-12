module Challenge
  class Benchmark
    class << self
      def before_block
        @@before
      end

      def action_block
        @@action
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
  end
end
