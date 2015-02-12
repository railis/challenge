Challenge::Spec.new do
  before do
    @queue = @solution_class.new
  end
  
  it "should raise errors for empty queue " do
    expect(@queue.min).to be_nil
    expect(@queue.pop).to be_nil
  end  
  
  it "should push, min and pop" do
    @queue.push("aaa", 10)
    @queue.push("bbb", 30)
    @queue.push("ccc", 20)
    expect(@queue.min).to eq("aaa")
    expect(@queue.pop).to eq("aaa")
    expect(@queue.min).to eq("ccc")
    expect(@queue.pop).to eq("ccc")
    expect(@queue.min).to eq("bbb")
    expect(@queue.pop).to eq("bbb")
  end
  
  it "should not allow duplicate objects" do
    @queue.push("aaa", 10)
    expect { @queue.push("aaa", 20) }.to raise_error
  end
  
  it "should allow duplicate keys" do 
    @queue.push("aaa", 10)
    @queue.push("bbb", 10)
    obj1 = @queue.pop
    obj2 = @queue.pop
    expect(["aaa", "bbb"]).to include(obj1)
    expect(["aaa", "bbb"] - [obj1]).to include(obj2)
  end
  
  it "should decrease key" do
    @queue.push("aaa", 10)
    @queue.push("bbb", 30)
    @queue.push("ccc", 20)
    @queue.decrease_key("bbb", 5)
    @queue.decrease_key("ccc", 8)
    expect(@queue.pop).to eq("bbb")
    expect(@queue.pop).to eq("ccc")
    expect(@queue.pop).to eq("aaa")
  end
  
  it "should raise error when new key is greater then old key while decreasing key" do
    @queue.push("aaa", 10)
    expect { @queue.decrease_key("aaa", 20) }.to raise_error
  end
    
end
