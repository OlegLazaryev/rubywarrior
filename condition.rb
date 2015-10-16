class Condition
	FULL_HEALTH = 20
	HALF_ALIVE = 12

	attr_accessor :current_health, :health

	def initialize
		@health = FULL_HEALTH
	end

	def set_current_health		
		@health = current_health
	end

	def injured?
		current_health < FULL_HEALTH
	end

	def severe_injured?
		current_health < HALF_ALIVE
	end

	def not_injuring_now?
		health <= current_health
	end
end
