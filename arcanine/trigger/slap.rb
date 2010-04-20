class Arcanine::Trigger::Slap < Arcanine::Trigger

=begin
  command: slap
  description: trout slap a ho
=end

  def self.regex
    /^slap\s+([^\s]+)\s*$/i
  end

  def self.action(arcanine, irc, target)
    irc.respond "\001ACTION slaps #{target} around a bit with a large trout.\001"
  end
end

