module Challenge
  class Spec
    class << self
      def block
        @@block
      end

      def examples
        @@examples
      end
    end

    def initialize(&block)
      @@block = block
    end
  end
end
