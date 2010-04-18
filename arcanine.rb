require 'on_irc'

class Arcanine
	attr_reader :monitor

  def initialize(template)
    @help = Arcanine::HelpGenerator.for_syntax('ruby').convert(File.read 'bot-eval.rb')
    @trigger_char = template[:trigger_char] || template['trigger_char'] || '@'
    @realname = __realname = template[:realname] || template['realname']
    @ident = __ident = template[:ident] || template['ident']
    @servers = __servers = template[:servers] || template['servers']
    @nick = __nick = template[:nick] || template['nick']
    @triggers = []
		@monitor = {}

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
      puts "[#{server.name}] #{sender}: #{command} - #{params.inspect}"
		end

		arcanine = self

		@bot.on :privmsg do
			if params[0][0,1] == '#' && arcanine.monitor[server.name].include?(params[0])
				begin
			    eval File.read('bot-eval.rb')
			  rescue Exception => error
			    puts "Eval Error: #{error}"
			  end
			elsif params[0][0,1] != '#'
				# do something
				puts ""
			end
    end

    @bot.on :ping do
      pong params[0]
    end

		for s in @servers
			@bot[s[:name]].on '001' do
				s[:channels].each { |c|	join c }
			end
			@monitor[s[:name]] = s[:channels] || []
		end

    @bot.connect
  end
end

=begin

if params[0][0,1] == '#'
  if params[1][0,1] == $trigger_char
    msg = params[1][1..-1]
    for trigger in $triggers
      trigger.send :run, self and break if trigger.send :match, msg
    end
  end
end



----------------------


bot[:freenode].on :privmsg do
  begin
    eval File.new('bot-eval.rb').gets(nil)
  rescue Exception => error_msg
    puts error_msg
  end
end





bot.connect
=end
