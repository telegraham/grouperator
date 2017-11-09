class Vote

  attr_reader :rank, :boot, :pitch

  def initialize(args)
    @rank = args.fetch(:rank)
    @boot = args.fetch(:boot)
    @pitch = args.fetch(:pitch)

    @boot.add_vote(self)
  end

end