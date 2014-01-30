require 'debugger'
class Array

  def my_collect
    to_return = []
    if self.length == 1
      to_return = yield self.first
    elsif self.length > 1
      to_return = self.collect do |element|
        yield element
      end
    end
    return to_return
  end

end

class ChangeMaker
    
  def initialize(coins = [20,10,5,1])
    @coins = coins.sort
    @cache = Hash.new {|h,k| h[k] = []}
  end

  def possible(amount)
    @coins.select do |coin|
      coin <= amount
    end
  end

  def run(amount)
    num_coins(make_change(amount, []))
  end

  def num_coins(solutions)
    answer = solutions.sort {|solutiona, solutionb| solutiona.size <=> solutionb.size }.collect do |solution|
      {solution.size => solution}
    end
    remove_dups(answer)
  end

  def get_keys(solutions)
    solutions.collect do |solution|
      solution.keys.first
    end.uniq
  end

  def solutions_with_key(key, solutions)
    solutions.select{|solution| solution.keys.include?(key)}.collect do |solution|
      solution[key]
    end
  end

  def remove_dups(solutions)
    array = []
    get_keys(solutions).each do |key|
      solutions_with_key(key, solutions).collect {|subarray| subarray.sort }.uniq.each do |solution|
        array << {key => solution}
      end
    end
    return array
  end

  def make_change(amount, change)
    return [change] if amount == 0
    return possible(amount).collect do |coin|
      make_change(amount - coin, change + [coin])
    end.flatten(1)
  end

end
t1 = Time.now
puts ChangeMaker.new.run(25).inspect
t2 = Time.now
puts "it took #{t2 - t1} seconds to solve this"