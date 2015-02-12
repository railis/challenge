module Challenge
  class Spec
    class << self
      def block
        @@block
      end
    end

    def initialize(&block)
      @@block = block
    end
  end
end
