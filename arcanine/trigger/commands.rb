class Arcanine::Trigger::Commands < Arcanine::Trigger
  def self.regex
    /^commands\s*$/i
  end

  def self.action(irc)
    irc.respond $help.keys.join ', '
  end
end

