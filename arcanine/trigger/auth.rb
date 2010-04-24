class Arcanine::Trigger::Auth < Arcanine::Trigger

=begin
  command: auth
  description: authenticate as an admin
=end

  def self.regex
    /^auth (.*)$/i
  end

  def self.action(arcanine, irc, password)
    if irc.params[0][0,1] == '#'
      irc.respond "Not in a channel..."
    elsif password == arcanine.password
      credentials = [irc.sender.host, irc.sender.nick]
      if arcanine.authed_users.include? credentials
        irc.respond "Already authenticted."
      else
        arcanine.authed_users << credentials
        irc.respond "Successfully authenticated."
      end
    end
  end
end

