class Arcanine::Trigger::AsciiFart < Arcanine::Trigger

=begin
  command: asciifart
  aliases: fart af
  description: prints a random and annoying ASCII Art Fart
=end

  def self.regex
    /^(?:asciifart|fart|af)$/i
  end

  def self.action(irc)
    `fortune data/fortune.txt`.split(/\r?\n/).each { |line| irc.respond line }
  end
end

