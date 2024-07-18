require "rspec"

require_relative "app"

RSpec.describe "Greedy Savings" do
  subject(:app) { App.new }

  it "works" do
    expect(App).not_to be_nil
  end

  describe "#calculate" do
    subject { app.calculate(10000) }

    it "returns array of allocations" do
      is_expected.to be_an Array
    end

    context "when having bank account with 3% interest rate in the first 10000 THB" do
      before do
        app.banks = [Bank.new("Foo Bank", 0..10000 => 0.03)]
      end

      it "returns array of 1 allocation" do
        expect(subject.count).to eq 1

        expect(subject[0].bank_name).to eq "Foo Bank"
        expect(subject[0].amount).to eq 10000
        expect(subject[0].interest_rate).to eq 0.03
        expect(subject[0].total).to eq 10000 * 0.03
      end
    end

    context "when having bank account with 3% interest rate in the first 1000 THB and another with 5% interest rate in the next 1000 THB" do
      before do
        app.banks = [Bank.new("Foo Bank", 0..1000 => 0.03, 1000..10000 => 0.05)]
      end

      it "returns array of 2 allocations" do
        expect(subject.count).to eq 2

        expect(subject[0].bank_name).to eq "Foo Bank"
        expect(subject[0].amount).to eq 1000
        expect(subject[0].interest_rate).to eq 0.03
        expect(subject[0].total).to eq 1000 * 0.03

        expect(subject[1].bank_name).to eq "Foo Bank"
        expect(subject[1].amount).to eq 9000
        expect(subject[1].interest_rate).to eq 0.05
        expect(subject[1].total).to eq 9000 * 0.05
      end
    end
  end
end
