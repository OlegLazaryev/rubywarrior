class Player

	def initialize
		@health = 0
	end

  def play_turn(warrior)
  	warrior.pivot! and return if warrior.feel.wall? || archer_backward?(warrior)  	

    if warrior.feel.empty?
    	if (warrior.health < 20)
    		look = warrior.look
    		closest_space = detect_closest_unit(warrior)
    		if closest_space && closest_space.enemy?
    			warrior.shoot!
    		elsif !damage?(warrior)
    			warrior.rest!
			elsif warrior.health < 12
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

  def archer_backward?(warrior)
  	space  = detect_closest_unit(warrior, :backward)
  	return unless space  		
  	unit = space.unit
  	return unless unit
  	unit.name == 'Archer'
  end

  def detect_closest_unit(warrior, direction = :forward)
  	look = warrior.look(direction)
    look.detect { |space| !space.empty? }
  end

  def damage?(warrior)
  	@health > warrior.health
  end

end
