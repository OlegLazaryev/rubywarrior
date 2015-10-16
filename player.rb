class Player
	def initialize
		@health = 0
	end

  def play_turn(warrior)
  	puts 'Health Before'
  	puts @health
  	puts warrior.health

    if warrior.feel.empty?
    	if (warrior.health < 20) && !damage?(warrior)
    		warrior.rest!
    	else
    		warrior.walk!
    	end	
    else
    	if warrior.feel.captive?
    		warrior.rescue!
    	else    		
			warrior.attack!
		end
    end
    @health = warrior.health

    puts 'Health After'
  	puts @health
  	puts warrior.health
  end

  private

  def damage?(warrior)
  	@health > warrior.health
  end

end
