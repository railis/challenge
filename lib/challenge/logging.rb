require 'colorize'

module Challenge
  class Logging
    class << self
      COLORS = {
        info: :light_blue,
        solution_name: :yellow
      }
      
      COLORS.each do |k,v|
        define_method k do |str|
          puts str.colorize(v)
        end
      end
    end
  end
end
