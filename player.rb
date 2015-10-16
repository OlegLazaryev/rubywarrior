require 'environment'
require 'condition'

class Player

	def initialize
		@condition = Condition.new
		@environment = nil
	end

  def play_turn(warrior)
  	before_turn(warrior)
  	process(warrior)    
    after_turn
  end

  private

  def before_turn(warrior)
  	@environment = Environment.new(warrior)
  	condition.current_health = warrior.health
  end

  def after_turn
  	condition.set_current_health
  end

  def process(warrior)
	warrior.pivot! and return if need_to_pivot?

    if environment.nothing_forward?
		chase_the_enemy(warrior)
    else
    	save_the_captive(warrior)
    end
  end

  attr_reader :condition, :environment

  def need_to_pivot?
  	environment.wall_forward? || environment.archer_backward?
  end

  def chase_the_enemy(warrior)
  	if condition.injured?
  		reinforce(warrior)
    else
    	offense(warrior)
    end
  end

  def save_the_captive(warrior)
  	warrior.rescue! if environment.captive_forward?
  end

  def reinforce(warrior)
  	if environment.enemy_forward?
    	warrior.shoot!
    elsif condition.not_injuring_now?
    	warrior.rest!
	elsif condition.severe_injured?
		warrior.walk!(:backward)
	else
		warrior.walk!
	end
  end

  def offense(warrior)
  	if environment.safe_attack?
    	warrior.shoot!
    else
    	warrior.walk!
    end
  end

end
