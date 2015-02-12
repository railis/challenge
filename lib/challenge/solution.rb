module Challenge
  class Solution
    def self.get_all(puzzle)
      path = File.expand_path("../../../puzzles/#{puzzle}/solutions/", __FILE__)
      solution_files = Dir.glob(path + "/*.rb")
      solution_files.map do |file_path|
        self.new(file_path)
      end
    end

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
      require file_path
    end

    def path
      file_path
    end

    def name
      File.basename(path, ".rb").capitalize
    end

    def class
      Object.const_get(name)
    end
  end
end
