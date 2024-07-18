class Allocation < Struct.new(:amount, :interest_rate, :total, :bank_name)
end

class Bank < Struct.new(:name, :interest_rates)
end

class App
  attr_accessor :banks

  def initialize
    @banks = []
  end

  def calculate(amount)
    _banks = banks.dup

    return [] if _banks.empty?

    allocations = []

    while amount > 0
      best_bank_idx = _banks.each_with_index.max_by { |(bank)| bank.interest_rates.values[0] }[1]
      range, interest_rate  = _banks[best_bank_idx].interest_rates.shift

      max_deposit = [range.end - range.begin, amount].min
      allocation = Allocation.new
      allocation.bank_name = _banks[best_bank_idx].name
      allocation.amount = max_deposit
      allocation.interest_rate = interest_rate
      allocation.total = max_deposit * interest_rate
      amount -= max_deposit

      allocations << allocation
    end

    allocations
  end
end
