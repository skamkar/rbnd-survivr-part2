class Jury

  def initialize
    @jury = []
    @finalists = {}
  end

  def add_member(member)
    @jury << member
  end

  def members
    @jury
  end

  def members=(members)
    members.each do |member|
      add_member(member)
    end
  end

  def cast_votes(finalists)
    names = []
    tally = []

    # Jury randomly chooses 1 of 2 finalists
    selection = Array.new(7){rand(0..1)}
    tally[0] = selection.count(0)
    tally[1] = selection.count(1)

    # Create finalists hash (values -> number of votes)
    finalists.each_with_index do |finalist, index|
      @finalists[finalist] = tally[index]
      names << finalist.name
    end

    # Print votes to terminal
    puts "#{names.first.light_blue}\n" * tally[0]
    puts "#{names.last.blue}\n"  * tally[1]

    @finalists
  end

  # Print votes to terminal
  def report_votes(final_votes)
    final_votes.each do |final_vote|
      puts "#{final_vote[0].name.pink} earned #{final_vote[1]} vote(s)."
    end
  end

  def announce_winner(final_votes)
    winner = final_votes.max_by{|k,v| v}[0]
    puts "#{winner.name.upcase} IS THE GRAND WINNER!".green
    winner
  end
end