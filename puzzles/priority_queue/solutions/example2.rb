class Example2
  attr_accessor :line
  
  def initialize 
    self.line = {}
  end 
  
  def push(object, key)
    puts "push 2"
    raise Exception if self.line[object]
    self.line[object] = key
  end
  
  def min
    puts "min 2"
    min_value, min_key = self.line.min{|a,b| a.last <=> b.last}
    return min_value
  end
  
  def pop
    puts "pop 2"
    key = self.min
    self.line.delete(key)
    return key
  end
  
  def decrease_key(object, key)
    put "decrease key 2"
    self.line[object] < key ? (raise Exception) : self.line[object] = key
  end
end
