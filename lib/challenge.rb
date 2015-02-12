%w{runner solution benchmark measurement profiler results}.each do |e|
  require File.dirname(__FILE__) + "/challenge/#{e}"
end

module Challenge
end
