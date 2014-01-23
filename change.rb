require 'debugger'
class ChangeMaker
    
  def initialize(coins = [50,25])
    @coins = coins.sort
  end

  def possible(amount)
    @coins.select do |coin|
      coin <= amount
    end
  end

  def make_change(amount)
    return {0 => []} if amount == 0
    change = Hash.new {|h,k| h[k] = []}
    possible(amount).each do |coin|
      change[amount] << [coin] + make_change(amount - coin)[amount - coin]
    end
    return change
  end

end

puts ChangeMaker.new.make_change(100).inspect