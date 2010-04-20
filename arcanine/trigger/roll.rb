class Arcanine::Trigger::Roll < Arcanine::Trigger

=begin
  command: roll
  description: generate a random dice roll
=end

  def self.regex
    /^roll\s*([1-9])d([2-9]\d*)\s*$/i
  end

  def self.action(arcanine, irc, num_dice, sides)
    nick      = irc.sender.nick
    roll      = num_dice + 'd' + sides
    results_a = roll num_dice.to_i, sides.to_i
    results   = results_a.join ', '
    total     = 0
    results_a.each { |r| total += r }
    irc.respond "#{nick} rolled #{roll}: #{results} = #{total}"
  end

  def self.roll(num_dice, sides)
    roll    = proc { rand(sides) + 1 }
    results = []
    num_dice.times do
      results << roll.call
    end
    results
  end
end

