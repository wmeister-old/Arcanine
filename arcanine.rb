require 'on_irc'

class Arcanine
  def initialize(template)
    @help = Arcanine::HelpGenerator.for_syntax('ruby').convert(File.read 'bot-eval.rb')
    @trigger_char = template[:trigger_char] || template['trigger_char'] || '@'
    @realname = __realname = template[:realname] || template['realname']
    @ident = __ident = template[:ident] || template['ident']
    @servers = __servers = template[:servers] || template['servers']
    @nick = __nick = template[:nick] || template['nick']
    @triggers = []

    @bot = IRC.new do
      nick     __nick
      ident    __ident
      realname __realname

      for s in __servers
        server s[:name] do
					address s[:host]
					port    s[:port]
				end
      end
    end
  end

  def connect_all
    @bot.on :all do
      puts "#{sender}: #{command} #{params.inspect}"
    end

    @bot.on :ping do
      pong params[0]
    end

    @bot.connect
  end
end

=begin

bot[:freenode].on '001' do
  join '#botters'
  join '#arcanine'
end

bot[:freenode].on :privmsg do
  begin
    eval File.new('bot-eval.rb').gets(nil)
  rescue Exception => error_msg
    puts error_msg
  end
end





bot.connect
=end
