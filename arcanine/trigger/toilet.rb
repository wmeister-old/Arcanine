class Arcanine::Trigger::Toilet < Arcanine::Trigger

=begin
  command: toilet
  aliases: banner annoy ascii
  description: uses toilet to print out text
=end

  def self.regex
    /^(?:toilet|annoy|banner|ascii)\s+(.*)\s*$/
  end

  def self.action(irc, text)
    File.popen 'toilet', 'w+' do |pipe|
        pipe.puts text
        pipe.close_write
        for line in pipe.read.split /\r?\n/
          irc.respond line
        end
    end
  end
end

