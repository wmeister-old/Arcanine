class Arcanine::Trigger::Commands < Arcanine::Trigger
  def self.regex
    /^commands\s*$/i
  end

  def self.action(arcanine, irc)
    cmds = Arcanine::Trigger.help.keys
    irc.respond "#{cmds.size} commands: #{cmds.sort.join ', '}"
  end
end

