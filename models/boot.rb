class Boot

  attr_reader :name

  def initialize(args)
    @name = args.fetch(:name)
    @votes = []
  end

  def to_s
    self.name
  end

  def add_vote(vote)
    @votes.push(vote)
  end

  def rank_for(pitch)
    vote = @votes.find do |vote|
      vote.pitch === pitch
    end

    vote ? vote.rank : 0
  end

end