require 'debugger'
class ChangeMaker
    
  def initialize(coins = [20,10,5,2,1])
    @coins = coins.sort
    @cache = Hash.new {|h,k| h[k] = []}
  end

  def possible(amount)
    @coins.select do |coin|
      coin <= amount
    end
  end

  def make_change(amount)
    if @cache[amount].size > 0
      # debugger
      # puts "returning #{@cache[amount]}"
      return {amount => @cache[amount]}
    end
    return {0 => []} if amount == 0
    change = Hash.new {|h,k| h[k] = []}
    possible(amount).each do |coin|
      begin
        solutions = make_change(amount - coin)[amount - coin]
        if solutions.size > 0
          solutions.each do |solution|
            change[amount] << [coin] + solution
          end
        else
          change[amount] << [coin]
        end
      rescue => e
        debugger
        puts 'hi'
      end
    end
    # debugger
    temp = [change[amount].sort {|solutiona, solutionb| solutiona.size <=> solutionb.size}.first]
    @cache[amount] = temp
    change[amount] = temp
    return change
  end

end

puts ChangeMaker.new.make_change(301).inspect