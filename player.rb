class Player
	def initialize
		@health = 0
	end

  def play_turn(warrior)
    if warrior.feel.empty?
    	if (warrior.health < 20)
    		if !damage?(warrior)
    			warrior.rest!
			elsif warrior.health < 6
				warrior.walk!(:backward)
			else
				warrior.walk!
			end
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
  end

  private

  def damage?(warrior)
  	@health > warrior.health
  end

end
