Challenge::Spec.new do
  before do
    @money = @solution_class.new
  end

  it "change" do
    expect(@money.change(5, [1, 2])).to match_array([2, 2, 1])
    expect(@money.change(10, [2, 3, 4])).to match_array([4, 4, 2])
    expect(@money.change(15, [4, 2, 1])).to match_array([4, 4, 4, 2, 1])
    expect(@money.change(25, [10, 5])).to match_array([10, 10, 5])
    expect(@money.change(9, [3, 2, 1])).to match_array([3, 3, 3])
    expect(@money.change(9, [2])).to match_array([])
    expect(@money.change(10, [])).to match_array([])
    expect(@money.change(10, [20])).to match_array([])
    expect(@money.change(5, [3,4])).to match_array([])
    expect(@money.change(8, [5,4,2,1])).to match_array([4,4])
    expect(@money.change(6, [4,3,1])).to match_array([3,3])
  end
end
