require 'environment'

class Player

	def initialize
		@health = 0
	end

  def play_turn(warrior)
  	environment ||= Environment.new(warrior)

  	warrior.pivot! and return if environment.wall_forward? || environment.archer_backward?

    if environment.nothing_forward?
    	if (warrior.health < 20)
    		if environment.enemy_forward?
    			warrior.shoot!
    		elsif !damage?(warrior)
    			warrior.rest!
			elsif warrior.health < 12
				warrior.walk!(:backward)
			else
				warrior.walk!
			end
    	else
    		if environment.safe_attack?
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
