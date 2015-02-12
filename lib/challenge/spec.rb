module Challenge
  class Spec
    @@examples = []
    class << self
      def before_block
        @@before_block
      end

      def examples
        @@examples
      end
    end

    def it(label, &block)
      @@examples << [label, block]
    end

    def before(&block)
      @@before_block = block
    end
  end
end
