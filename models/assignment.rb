class Assignment

  attr_reader :pitch_set
  attr_reader :scenario

  def initialize(args)
    @pitch_set = args.fetch(:pitch_set)
    @scenario = args.fetch(:scenario)
  end


  def spread
    score = scenario.groups.length.times.reduce({}) do |hash, idx|
      pitch = pitch_set.pitches[idx]
      group = scenario.groups[idx]

      group.members.each do |member|
        rank_from_member = member.rank_for(pitch)

        hash[rank_from_member] ||= 0
        hash[rank_from_member] += 1
      end

      hash
    end
    Hash[ score.sort_by { |key, val| (key * -1) } ]
  end

  def score_maximum_upside
    spread.reduce 0 do |accumulator, array|
      rank = array[0]
      count = array[1]

      accumulator + ((10 ** rank) * count)
    end
  end

  def score_minimum_downside
    spread.reduce 0 do |accumulator, array|
      rank = array[0]
      count = array[1]

      accumulator - ((10 ** (7 - (rank + 1))) * count)
    end
  end

  def to_s
    ret = [ "Possibility #{ self.hash }:" ]

    ret.concat (scenario.groups.length.times.map do |i|
      "#{ pitch_set.pitches[i] }: #{ scenario.groups[i] }"
    end.to_a)

    ret.push " ~ ~ ~ "

    ret.push spread.to_s
    ret.push "score_maximum_upside: #{ score_maximum_upside }"
    ret.push "score_minimum_downside: #{ score_minimum_downside }"

    ret.join("\n") + "\n\n"
  end

end