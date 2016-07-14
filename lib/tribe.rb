require 'colorizr'

class Tribe

  attr_reader :name, :members

  def initialize(options = {})
    @name = options[:name]
    @members = options[:members]
    puts "The #{@name.yellow} tribe has been created."
  end

  def to_s
    @name
  end

  def tribal_council(immune)
    if immune.keys[0] == :immune
      Contestant.new(nil)
    else
      immune.values[0]
    end
  end
end