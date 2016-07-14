require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require 'byebug'
require 'colorizr'

#After your tests pass, uncomment this code below
#=========================================================
# Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

# Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================

#This is where you will write your code for the three phases
def phase_one
  puts "\nPHASE ONE"
  eliminated = []
  8.times do
    # Eliminate random contestant
    # individual_immunity_challenge is overloaded to pick 'loser' instead of 'winner'
    eliminated << @borneo.individual_immunity_challenge

    # Determine losing team, delete member    
    losing_team = nil
    @borneo.tribes.each do |tribe|
      if tribe.members.map(&:name).include?(eliminated.last.name)
        losing_team = tribe.name
        tribe.members.delete(eliminated.last)
        break
      end
    end

    # Print result to terminal
    puts "#{losing_team.yellow} lost and has eliminated #{eliminated.last.name.red}."
  end

  eliminated.length
end

def phase_two
  # Perform phase_one if necessary
  unless @merge_tribe.members.length == 12
    phase_one
    @merge_tribe = @borneo.merge("Cello")
  end
  @merge_game = Game.new(@merge_tribe)

  puts "\nPHASE TWO"    
  eliminated = []
  immune = []

  3.times do
    # Eliminate random contestant for each challenge
    eliminated << @merge_game.individual_immunity_challenge
    @merge_tribe.members.delete(eliminated.last)
    puts "From #{@merge_tribe.name.yellow}, #{eliminated.last.name.red} has been eliminated."
    # Assign winner contestant (with immunity) for each challenge
    immune << @merge_game.individual_immunity_challenge
  end

  eliminated.length  
end

def phase_three
  # Perform phase_two (and phase_one) if necessary
  unless @merge_tribe.members.length == 9
    phase_two
  end

  puts "\nPHASE THREE"
  jury = []
  7.times do
    jury << @merge_game.individual_immunity_challenge
    @merge_tribe.members.delete(jury.last)
    puts "#{jury.last.name.red} has been eliminated and assigned to the Jury."
  end
  @jury.members = jury
  jury.length
end

# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists

puts "\nJURY VOTES:"
vote_results = @jury.cast_votes(finalists) #Jury members report votes

puts "\nJURY TALLY:"
@jury.report_votes(vote_results) #Jury announces their votes

puts "\nFINAL RESULT:"
@jury.announce_winner(vote_results) #Jury announces final winner
