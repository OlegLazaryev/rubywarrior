class Environment

  def initialize(warrior)
    @warrior = warrior
  end

  def archer_backward?
		space = detect_closest_space(:backward)
		unit = space && space.unit
		unit && unit.kind_of?(RubyWarrior::Units::Archer)
  end

  def enemy_forward?
	  closest_space = detect_closest_space
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

  def captive_forward?
    warrior.feel.captive?
  end

  private

  attr_reader :warrior

  def detect_closest_space(direction = :forward)
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
