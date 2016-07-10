class Game

  attr_reader :tribes

  def initialize(*tribes)
    @tribes = tribes
  end

  def add_tribe(tribe)
    @tribes << tribe
  end

  def immunity_challenge
    tribe_count = self.tribes.length
    selection = rand(0..tribe_count-1)
    self.tribes[selection]
  end

  def clear_tribes
    []
  end

  def merge(new_tribe_name)
    Tribe.new(name: new_tribe_name, members: all_contestants)
  end

  def individual_immunity_challenge
    selection = rand(0..all_contestants.length-1)
    all_contestants[selection]
  end

  private

  def all_contestants
    tribes.map(&:members).flatten
  end


end