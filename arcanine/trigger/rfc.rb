class Arcanine::Trigger::RFC < Arcanine::Trigger

=begin
  command: rfc
  description: returns a URL for a RFC
=end

  def self.regex
    /^rfc\s*([0-9]{1,4})\s*$/i
  end

  def self.action(arcanine, irc, num)
    irc.respond "http://www.ietf.org/rfc/rfc#{num}.txt"
  end
end

