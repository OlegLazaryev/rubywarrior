class Player
	def initialize
		@health = 0
	end

  def play_turn(warrior)
  	warrior.pivot! and return if warrior.feel.wall?

  	

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
    		if !warrior.look.any?(&:captive?) && warrior.look.any?(&:enemy?)
    			warrior.shoot!
    		else
    			warrior.walk!
    		end
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
