require_relative 'group'
require_relative 'scenario'

class SplittableGroup < Group

  attr_reader :max_group_size, :min_group_size

  def initialize(args)
    super(args)
    @max_group_size = args.fetch(:max_group_size)
    @min_group_size = args.fetch(:min_group_size)
  end

  def padded_members
    max_number_of_groups = (self.members.length / (self.min_group_size * 1.0)).floor
    target_array_length = max_number_of_groups * (self.min_group_size + 1)
    padders_needed = target_array_length - members.length
    self.members.clone.fill(nil, members.length, padders_needed)
  end

  def possible_groups
    array_of_combinations = padded_members.combination(self.max_group_size).to_a
    stripped_of_nils = array_of_combinations.map do | combo |
      combo.reject(&:nil?)
    end

    stripped_of_nils.uniq.map do |possible_group|
      Group.new(members: possible_group)
    end
  end

  def difference(group)
    SplittableGroup.new(members: self.members.clone - group.members.clone, 
      max_group_size: self.max_group_size, 
      min_group_size: self.min_group_size)
  end

  def splittable?
    self.members.count > self.max_group_size
  end

  def valid?
    self.members.count >= self.min_group_size
  end

  def all_scenarios()

    self.possible_groups.map do |possible_group|

      remainders = self.difference(possible_group)

      if remainders.splittable?
        remainders.all_scenarios.map do |scenario|
          scenario.add_group(possible_group)
          scenario
        end
      elsif remainders.valid?
        Scenario.new(groups: [possible_group, remainders])
      else #too small
        next
      end 
    end.flatten.reject(&:nil?)
  end
end