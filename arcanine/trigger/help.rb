class Arcanine::Trigger::Help < Arcanine::Trigger
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

