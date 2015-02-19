Challenge::Spec.new do
  context "when expression is invalid" do
    context "when it includes invalid characters" do
      let(:exp) { "1 + 2a" }

      it "raises error" do
        expect { @solution_class.new(exp).calculate }.to raise_error("Invalid character 'a'")
      end
    end

    context "when there are not closed parentheses" do
      let(:exp) { "((1 + 2 + 3) + 1" }

      it "raises error" do
        expect { @solution_class.new(exp).calculate }.to raise_error("Unmatched '('")
      end
    end
    
    context "when parentheses are closed more than once" do
      let(:exp) { "((1 + 2) + 1) + 4)" }

      it "raises error" do
        expect { @solution_class.new(exp).calculate }.to raise_error("Unmatched '('")
      end
    end
  end

  context "when expression is valid" do
    context "allows negative" do
      let (:exp) { "(-2) + 1" }

      it "returns calculated value" do
        expect(@solution_class.new(exp).calculate).to eq(-1)
      end
    end

    context "handles basic ordering" do
      it "returns calculated value based on attributes order" do
        expect(@solution_class.new("2+2*2").calculate).to eq(6)
        expect(@solution_class.new("10-4/2").calculate).to eq(8)
      end

      it "returns calculated value based on parentheses" do
        expect(@solution_class.new("(2+2)*2").calculate).to eq(8)
        expect(@solution_class.new("(10-4)/2").calculate).to eq(3)
      end
    end
  end
end
