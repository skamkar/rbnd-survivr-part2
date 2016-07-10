require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require 'byebug'

#After your tests pass, uncomment this code below
#=========================================================
# # Create an array of twenty hopefuls to compete on the island of Borneo
# @contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
# @contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!
#
# # Create two new tribes with names
# @coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
# @hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))
#
# # Create a new game of Survivor
# @borneo = Game.new(@coyopa, @hunapu)
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
    puts "#{losing_team} lost and have eliminated #{eliminated.last}."
  end
  eliminated.length
end

def phase_two
  # Phase 1 prep (conduct Phase 1, merge into a single tribe)
  phase_one
  @merged_tribe = @borneo.merge("Cello")
  @merged_game = Game.new(@merged_tribe)

  puts "\nPHASE TWO"    
  eliminated = []
  immune = []

  3.times do
    # Eliminate random contestant for each challenge
    eliminated << @merged_game.individual_immunity_challenge
    @merged_tribe.members.delete(eliminated.last)
    puts "From #{@merged_tribe.name}, #{eliminated.last} has been eliminated."
    # Assign winner contestant (with immunity) for each challenge
    immune << @merged_game.individual_immunity_challenge
  end

  eliminated.length  
end

def phase_three
  # Phase 1 & 2 prep
  phase_two

  puts "\nPHASE THREE"
  jury = []
  7.times do
    jury << @merged_game.individual_immunity_challenge
    @merged_tribe.members.delete(jury.last)
    puts "#{jury.last} has been eliminated and assigned to the Jury."
  end
  @jury.members = jury
  jury.length
end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
# phase_one #8 eliminations
# @merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
# phase_two #3 more eliminations
# @jury = Jury.new
# phase_three #7 elminiations become jury members
# finalists = @merge_tribe.members #set finalists
# vote_results = @jury.cast_votes(finalists) #Jury members report votes
# @jury.report_votes(vote_results) #Jury announces their votes
# @jury.announce_winner(vote_results) #Jury announces final winner
