class Trigger
  def self.inherited(subclass)
    $triggers << subclass
  end

  def self.regex
    raise 'Override me!'
  end

  def self.match(msg)
    @@matches =  self.regex.match msg
    msg       =~ self.regex
  end

  def self.run(irc)
    action(irc, *@@matches[1..-1])
  end

  def self.action
    raise 'Override me!'
  end
end

class AsciiFartTrigger < Trigger

=begin
  command: asciifart
  aliases: fart af
  description: prints a random and annoying ASCII Art Fart
=end

  def self.regex
    /^(?:asciifart|fart|af)$/i
  end

  def self.action(irc)
    `fortune data/fortune.txt`.split(/\r?\n/).each { |line| irc.respond line }
  end
end

class CommandTrigger < Trigger
  def self.regex
    /^commands\s*$/i
  end

  def self.action(irc)
    irc.respond $help.keys.join ', '
  end
end

class DateTimeTrigger < Trigger

=begin
  command: date
  alias: time
  description: display the current date and time
=end

  def self.regex
    /^(?:date|time)\s*$/i
  end

  def self.action(irc)
    irc.respond Time.now.to_s
  end
end

class DiceRollTrigger < Trigger

=begin
  command: roll
  description: generate a random dice roll
=end

  def self.regex
    /^roll\s*([1-9])d([2-9]\d*)\s*$/i
  end

  def self.action(irc, num_dice, sides)
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

class HelpTrigger < Trigger
  def self.regex
    /^help\s+(#{$help.keys.join '|'})\s*$/
  end

  def self.action(irc, cmd)
    aliases = ""
    unless $help[cmd][:aliases].nil?
      aliases = '[' + $help[cmd][:aliases].join('/') + '] '
    end
    irc.respond cmd + " #{aliases}- #{$help[cmd][:description]}"
  end
end

class RFCTrigger < Trigger

=begin
  command: rfc
  description: returns a URL for a RFC
=end

  def self.regex
    /^rfc\s*([0-9]{1,4})\s*$/i
  end

  def self.action(irc, num)
    irc.respond "http://www.ietf.org/rfc/rfc#{num}.txt"
  end
end

class SlapTrigger < Trigger

=begin
  command: slap
  description: trout slap a ho
=end

  def self.regex
    /^slap\s+([^\s]+)\s*$/i
  end

  def self.action(irc, target)
    irc.respond "\001ACTION slaps #{target} around a bit with a large trout.\001"
  end
end

class ToiletTrigger < Trigger

=begin
  command: toilet
  aliases: banner annoy ascii
  description: uses toilet to print out text
=end

  def self.regex
    /^(?:toilet|annoy|banner|ascii)\s+(.*)\s*$/
  end

  def self.action(irc, text)
    File.popen 'toilet', 'w+' do |pipe|
        pipe.puts text
        pipe.close_write
        for line in pipe.read.split /\r?\n/
          irc.respond line
        end
    end
  end
end

class UpTimeTrigger < Trigger

=begin
  command: uptime
  aliases: utime etime runtime
  description: report up time
=end

  def self.regex
    /^(?:runtime|etime|up?time)\s*$/i
  end

  def self.action(irc)
    irc.respond `ps --no-header -p #{$$} -o etime`.gsub /\s/, ''
  end
end

if params[0][0,1] == '#'
  if params[1][0,1] == $trigger_char
    msg = params[1][1..-1]
    for trigger in $triggers
      trigger.send :run, self and break if trigger.send :match, msg
    end
  end
end


