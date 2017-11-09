class Scenario

  attr_reader :groups

  def initialize(args = {})
    @groups = args.fetch(:groups, [])
  end

  def add_group(group)
    @groups.push(group)
  end

  def to_s
    ret = ["Scenario #{object_id}:"]
    ret.concat groups.map(&:to_s)
    ret.join("\n*\t")
  end

end