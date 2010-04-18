class Arcanine::Trigger::UpTime < Arcanine::Trigger

=begin
  command: uptime
  aliases: utime etime runtime
  description: report up time
=end

  def self.regex
    /^(?:runtime|etime|up?time)\s*$/i
  end

  def self.action(irc)
    irc.respond `ps --no-header -p #{$$} -o etime`.gsub /\s/, ''
  end
end

