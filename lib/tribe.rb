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
    non_immune = @members.reject{ |member| member == immune[:immune]}
    @members.delete(non_immune.sample)
  end
end