class PitchSet

  attr_reader :pitches

  def initialize(args)
    @pitches = args.fetch(:pitches)
  end

  def to_s
    self.pitches.map(&:to_s).join(", ")
  end

end