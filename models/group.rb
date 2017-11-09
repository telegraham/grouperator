class Group

  attr_reader :members

  def initialize(args)
    @members = args.fetch(:members)
  end

  def to_s
    self.members.sort_by(&:name).map(&:to_s).join(", ")
  end

end