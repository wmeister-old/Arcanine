class Arcanine::Trigger::Join < Arcanine::AuthenticatedTrigger

=begin
  command: join
  description: join a channel
=end

  def self.regex
    /^join\s+([#&][^\s\,]{1,200})\s*$/i
  end

  def self.action(arcanine, irc, channel)
    channels = arcanine.monitor[irc.server.name]
    if channels.include? channel
      irc.respond "Already in that channel."
    else
      irc.respond "Joining #{channel}..."
      channels << channel
      irc.join channel
    end
  end
end

