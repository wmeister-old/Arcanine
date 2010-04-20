class Arcanine::Trigger::Source < Arcanine::Trigger

=begin
  command: source
  description: returns a link to my source code
  alias: about code
=end

  def self.regex
    /^(?:source|about|code)\s*$/i
  end

  def self.action(arcanine, irc)
    irc.respond 'http://github.com/wmeister86/Arcanine'
  end
end

