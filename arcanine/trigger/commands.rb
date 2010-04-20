class Arcanine::Trigger::Commands < Arcanine::Trigger
  def self.regex
    /^commands\s*$/i
  end

  def self.action(arcanine, irc)
    irc.respond Arcanine::Trigger.help.keys.join ', '
  end
end

