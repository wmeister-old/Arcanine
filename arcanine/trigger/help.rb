class Arcanine::Trigger::Help < Arcanine::Trigger
  def self.regex
    /^help\s+(#{Arcanine::Trigger.help.keys.join '|'})\s*$/
  end

  def self.action(arcanine, irc, cmd)
    command = Arcanine::Trigger.help[cmd]
    aliases = ""

    unless command[:aliases].nil?
      aliases = '[' + command[:aliases].join('/') + '] '
    end
    irc.respond cmd + " #{aliases}- #{command[:description]}"
  end
end

