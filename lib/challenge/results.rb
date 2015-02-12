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
      txt = "\nSorted results (average for one iteration):\n".colorize(:light_blue)
      sorted_data.each_with_index do |el, idx|
        txt << solution_line(el, idx)
      end
      txt
    end

    private

    def sorted_data
      @data.select {|e| e.last.class == Float}.sort do |el1, el2|
        el1.last <=> el2.last
      end + 
      @data.select {|e| e.last.class != Float}
    end

    def solution_line(el, idx)
      if el.last.class == Float
        "#{idx+1}. #{el.first.name.colorize(:green)}".ljust(40) + "#{el.last.to_s.ljust(19, "0")} s\n".bold
      else
        "X.".colorize(:light_black) + " #{el.first.name.colorize(:red)}".ljust(38) + "#{el.last.to_s.center(21).upcase.bold.colorize(:light_red)}" + "\n".bold
      end
    end
  end
end
