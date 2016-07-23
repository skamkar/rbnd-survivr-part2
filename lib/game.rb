class Game

  attr_reader :tribes

  def initialize(*tribes)
    @tribes = ([] << tribes).flatten!
  end

  def add_tribe(tribe)
    @tribes << tribe
  end

  def immunity_challenge
    @tribes.sample
  end

  def clear_tribes
    @tribes.clear
  end

  def merge(new_tribe_name)
    Tribe.new(name: new_tribe_name, members: all_contestants)
  end

  def individual_immunity_challenge
    @tribes.first.members.sample
  end

  private

  def all_contestants
    tribes.map(&:members).flatten
  end


end