class Pitch

  attr_reader :name

  def initialize(args)
    @name = args.fetch(:name)
  end

  def to_s
    self.name
  end

end