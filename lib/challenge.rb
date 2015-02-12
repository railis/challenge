%w{runner solution benchmark spec test_suite measurement profiler results logging}.each do |e|
  require File.dirname(__FILE__) + "/challenge/#{e}"
end

module Challenge
end
