class ExpressionParser
  attr_reader :exp

  def initialize(exp)
    @exp = exp
  end

  def parse
    validate_chars
    validate_brackets
    @exp.gsub(/\s+/,"").scan(ExpressionGrammar::ALL)
  end

  def validate_chars
    stripped = strip_grammar
    unless stripped == ''
      bad_char = stripped[0]
      raise "Invalid character '#{bad_char}'"
    end
  end

  def validate_brackets
    stack = []
    exp.scan(ExpressionGrammar::BRACKET).each do |char|
      if char == "("
        stack.unshift("(")
      elsif char == ")"
        if stack.empty?
          raise "Unmatched ')'"
        else
          stack.shift
        end
      end
    end
    unless stack.empty?
      raise "Unmatched '('"
    end
  end

  private

  def strip_grammar
    exp.gsub(/\s+/,'').gsub(ExpressionGrammar::ALL,'')
  end
end

class ExpressionGrammar
  NUMBER = /\d+/
  OPERATOR = /[\+|\-|\/|\*]/
  BRACKET = /[\(|\)]/
  LEFT_BRACKET = /\(/
  RIGHT_BRACKET = /\)/
  ALL = /#{NUMBER}|#{OPERATOR}|#{BRACKET}/
  PRIORITIES = {
    "+" => 1,
    "-" => 1,
    "/" => 2,
    "*" => 2
  }

  class << self
    def get_grammar_type(str)
      case str
      when NUMBER
        :number
      when OPERATOR
        :operator
      when LEFT_BRACKET
        :left_bracket
      when RIGHT_BRACKET
        :right_bracket
      else
        :unknown
      end
    end

    def compare_priority(operator1, operator2)
      p1 = PRIORITIES[operator1]
      p2 = PRIORITIES[operator2]
      if p1 > p2
        -1
      elsif p1 < p2
        1
      else
        0
      end
    end
  end
end

class InfixExpression
  attr_reader :exp

  def initialize(exp)
    @exp = exp
  end

  def convert_to_postfix
    postfix_order.join(" ")
  end

  def postfix_order
    result = []
    stack = []
    parsed.each do |item|
      case type(item)
      when :number
        result << item
      when :operator
        while !stack.empty? and type(stack.first) == :operator and comp_priority(stack.first, item) == -1 do
          el = stack.shift
          result << el
        end
        stack.unshift(item)
      when :left_bracket
        stack.unshift(item)
      when :right_bracket
        el = stack.shift
        while type(el) != :left_bracket do
          result << el
          el = stack.shift
        end
      end
    end
    result.concat(stack)
  end

  def evaluate
    stack = []
    postfix_order.each do |item|
      case type(item)
      when :number
        stack.unshift(item)
      when :operator
        n1 = stack.shift
        n2 = stack.shift
        stack.unshift calculate(n1,n2,item)
      end
    end
    stack.last.to_i
  end

  private

  def calculate(item1, item2, operator)
    case operator
    when "+"
      item2.to_i + item1.to_i
    when "-"
      item2.to_i - item1.to_i
    when "*"
      item2.to_i * item1.to_i
    when "/"
      item2.to_i / item1.to_i
    end
  end

  def type(el)
    ExpressionGrammar.get_grammar_type(el)
  end

  def comp_priority(e1, e2)
    ExpressionGrammar.compare_priority(e1, e2)
  end

  def parsed
    ExpressionParser.new(exp).parse
  end
end

class Dominik
  attr_reader :exp

  def initialize(exp)
    @exp = exp
  end

  def calculate
    InfixExpression.new(exp).evaluate
  end
end
