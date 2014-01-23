require 'debugger'
class ChangeMaker
    
  def initialize(coins = [50,25,10,5,1])
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
      solutions = make_change(amount - coin)[amount - coin]
      if solutions.size > 0
        solutions.each do |solution|
          change[amount] << [coin] + solution
        end
      else
        change[amount] << [coin]
      end
    end
    return change
  end

end

puts ChangeMaker.new.make_change(8).inspect