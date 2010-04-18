class Arcanine::Trigger::Date < Arcanine::Trigger

=begin
  command: date
  alias: time
  description: display the current date and time
=end

  def self.regex
    /^(?:date|time)\s*$/i
  end

  def self.action(irc)
    irc.respond Time.now.to_s
  end
end

