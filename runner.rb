start_time = Time.now

require_relative 'models/boot'
require_relative 'models/pitch'
require_relative 'models/vote'
require_relative 'models/splittable_group'
require_relative 'models/assignment'
require_relative 'models/pitch_set'

#cohort
eric = Boot.new(name: "Eric")
austin = Boot.new(name: "Austin")
baska = Boot.new(name: "Baska")
charlie = Boot.new(name: "Charlie")
kristin = Boot.new(name: "Kristin")
matt_black = Boot.new(name: "Matt")
melissa = Boot.new(name: "Melissa")
michelle = Boot.new(name: "Michelle")
pat = Boot.new(name: "Pat")
vikky = Boot.new(name: "Vikky")

cohort = [eric, austin, baska, charlie, kristin, matt_black, melissa, michelle, pat, vikky]


#pitches
scary = Pitch.new(name: "scary")
baby = Pitch.new(name: "baby")
ginger = Pitch.new(name: "ginger")
posh = Pitch.new(name: "posh")
sporty = Pitch.new(name: "sporty")

pitches = [scary, baby, ginger, posh, sporty]


#votes
votes = [
  Vote.new(boot: austin, pitch: scary, rank: 5),
  Vote.new(boot: austin, pitch: baby, rank: 4),
  Vote.new(boot: austin, pitch: ginger, rank: 3),
  Vote.new(boot: austin, pitch: posh, rank: 2),
  Vote.new(boot: austin, pitch: sporty, rank: 1),

  Vote.new(boot: eric, pitch: scary, rank: 4),
  Vote.new(boot: eric, pitch: baby, rank: 5),
  Vote.new(boot: eric, pitch: ginger, rank: 3),
  Vote.new(boot: eric, pitch: posh, rank: 2),
  Vote.new(boot: eric, pitch: sporty, rank: 1),

  Vote.new(boot: baska, pitch: scary, rank: 1),
  Vote.new(boot: baska, pitch: baby, rank: 2),
  Vote.new(boot: baska, pitch: ginger, rank: 3),
  Vote.new(boot: baska, pitch: posh, rank: 4),
  Vote.new(boot: baska, pitch: sporty, rank: 5),

  Vote.new(boot: charlie, pitch: scary, rank: 2),
  Vote.new(boot: charlie, pitch: baby, rank: 1),
  Vote.new(boot: charlie, pitch: ginger, rank: 3),
  Vote.new(boot: charlie, pitch: posh, rank: 4),
  Vote.new(boot: charlie, pitch: sporty, rank: 5),

  Vote.new(boot: kristin, pitch: scary, rank: 3),
  Vote.new(boot: kristin, pitch: baby, rank: 2),
  Vote.new(boot: kristin, pitch: ginger, rank: 1),
  Vote.new(boot: kristin, pitch: posh, rank: 4),
  Vote.new(boot: kristin, pitch: sporty, rank: 5),

  Vote.new(boot: matt_black, pitch: scary, rank: 2),
  Vote.new(boot: matt_black, pitch: baby, rank: 5),
  Vote.new(boot: matt_black, pitch: ginger, rank: 1),
  Vote.new(boot: matt_black, pitch: posh, rank: 3),
  Vote.new(boot: matt_black, pitch: sporty, rank: 4),

  Vote.new(boot: melissa, pitch: scary, rank: 1),
  Vote.new(boot: melissa, pitch: baby, rank: 5),
  Vote.new(boot: melissa, pitch: ginger, rank: 4),
  Vote.new(boot: melissa, pitch: posh, rank: 3),
  Vote.new(boot: melissa, pitch: sporty, rank: 2),

  Vote.new(boot: michelle, pitch: scary, rank: 1),
  Vote.new(boot: michelle, pitch: baby, rank: 5),
  Vote.new(boot: michelle, pitch: ginger, rank: 4),
  Vote.new(boot: michelle, pitch: posh, rank: 3),
  Vote.new(boot: michelle, pitch: sporty, rank: 2),

  Vote.new(boot: pat, pitch: scary, rank: 1),
  Vote.new(boot: pat, pitch: baby, rank: 5),
  Vote.new(boot: pat, pitch: ginger, rank: 4),
  Vote.new(boot: pat, pitch: posh, rank: 3),
  Vote.new(boot: pat, pitch: sporty, rank: 2),

  Vote.new(boot: vikky, pitch: scary, rank: 1),
  Vote.new(boot: vikky, pitch: baby, rank: 5),
  Vote.new(boot: vikky, pitch: ginger, rank: 4),
  Vote.new(boot: vikky, pitch: posh, rank: 3),
  Vote.new(boot: vikky, pitch: sporty, rank: 2),

]




splittable_group = SplittableGroup.new(members: cohort, max_group_size: 5, min_group_size: 3)


by_group_size = splittable_group.all_scenarios.reduce({}) do |hash, scenario|
  hash[scenario.groups.length] ||= []
  hash[scenario.groups.length].push(scenario)
  hash
end

blah = by_group_size.keys.map do |group_size|

  scenaria_of_this_group_size = by_group_size[group_size]

  pitches.combination(group_size).map do |combo|
    scenaria_of_this_group_size.map do |scenario|
      Assignment.new({
        scenario: scenario, 
        pitch_set: PitchSet.new(pitches: combo)
      })
    end
  end

end

sorted = (blah.flatten.sort_by do |assignment| 
  assignment.score_minimum_downside
end).to_a

puts sorted


puts "considered #{ sorted.length } possibilities in #{ Time.now - start_time } seconds"
