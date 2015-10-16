require 'environment'
require 'condition'

class Player

	def initialize
		@condition = Condition.new
	end

  def play_turn(warrior)
  	environment = Environment.new(warrior)
  	condition.current_health = warrior.health

  	warrior.pivot! and return if environment.wall_forward? || environment.archer_backward?

    if environment.nothing_forward?
    	if condition.injured?
    		if environment.enemy_forward?
    			warrior.shoot!
    		elsif condition.not_injuring_now?
    			warrior.rest!
			elsif condition.severe_injured?
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
    condition.set_current_health
  end

  private

  attr_reader :condition

end
