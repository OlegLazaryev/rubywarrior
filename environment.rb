class Environment

	def initialize(warrior)
		@warrior = warrior
	end

	def archer_backward?
  		space  = detect_closest_unit(:backward)
  		return unless space  		
  		unit = space.unit
  		return unless unit
  		unit.name == 'Archer'
    end

    def enemy_forward?
		closest_space = detect_closest_unit
		closest_space && closest_space.enemy?
    end

    def wall_forward?
    	warrior.feel.wall?
    end

    def nothing_forward?
    	warrior.feel.empty?
    end

    def safe_attack?
    	no_captives_detected? && enemy_detected?
    end

    private

    attr_reader :warrior

    def detect_closest_unit(direction = :forward)
  		look = warrior.look(direction)
    	look.detect { |space| !space.empty? }
    end

    def no_captives_detected?
    	!warrior.look.any?(&:captive?)
    end

    def enemy_detected?
    	warrior.look.any?(&:enemy?)
    end


end
