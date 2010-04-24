class Arcanine::Trigger::Part < Arcanine::AuthenticatedTrigger

=begin
  command: part
  description: leave a channel
=end

  def self.regex
    /^part\s+([#&][^\s\,]{1,200})\s*$/i
  end

  def self.action(arcanine, irc, channel)
    channels = arcanine.monitor[irc.server.name]
    if channels.include? channel
      irc.respond "Parting #{channel}..."
      channels.delete channel
      irc.part channel
    else
      irc.respond "I'm not in that channel."
    end
  end
end
