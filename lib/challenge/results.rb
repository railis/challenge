require 'colorize'

module Challenge
  class Results
    def initialize
      @data = []
    end

    def push(solution, result)
      @data << [solution, result]
    end

    def print
      puts pretty_results
    end

    def pretty_results
      txt = "\nSorted results (average after 5 iterations):\n".colorize(:light_blue)
      @data.sort do |el1, el2|
        el1.last <=> el2.last
      end.each_with_index do |el, idx|
        txt << "#{idx+1}. #{el.first.name.colorize(:green)}".ljust(40) + "#{el.last.to_s.ljust(19, "0")} s\n".bold
      end
      txt
    end
  end
end
