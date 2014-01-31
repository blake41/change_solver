require 'debugger'
class ChangeMaker
    
  def initialize(coins = [25,10,5,1])
    @coins = coins.sort
  end

  def possible(amount)
    @coins.select do |coin|
      coin <= amount
    end
  end

  def run(amount,find_best = true)
    if find_best 
      return  best(num_coins(make_change(amount, [])))
    else
      return num_coins(make_change(amount, []))
    end
  end

  def best(solutions)
    solutions.first
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
puts ChangeMaker.new.run(51).inspect
t2 = Time.now
puts "it took #{t2 - t1} seconds to solve this"
