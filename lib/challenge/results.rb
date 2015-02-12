module Challenge
  class Results
    def initialize
      @data = []
    end

    def push(solution, result)
      @data << [solution, result]
    end

    def print
      puts @data.inspect
    end
  end
end
