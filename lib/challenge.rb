%w{benchmark_runner solution benchmark measurement profiler results logging}.each do |e|
  require File.dirname(__FILE__) + "/challenge/#{e}"
end

module Challenge
end
