require 'on_irc'
require 'arcanine/trigger'
require 'arcanine/authenticated_trigger'

class Arcanine
  attr_reader   :trigger_char, :help, :password
  attr_accessor :monitor, :authed_users

  def initialize(template)
    @password = template[:password] || template['password'] or raise 'password must be set in configuation!'
    @trigger_char = template[:trigger_char] || template['trigger_char'] || '@'
    @realname = __realname = template[:realname] || template['realname']
    @ident = __ident = template[:ident] || template['ident']
    @servers = __servers = template[:servers] || template['servers']
    @nick = __nick = template[:nick] || template['nick']
    @authed_users = []
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
    load_triggers
  end

  def authenticated(sender)
    @authed_users.include? [sender.host, sender.nick]
  end 

  def trigger_files
    Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/arcanine/trigger/*.rb')
  end

  def load_triggers
    files    = trigger_files
    contents = ''

    for file in files
      begin 
        load file
      rescue Exception => e
        puts "Error in #{file}: #{e}"
        exit
      end
      contents << File.read(file)
    end

    @help = Arcanine::HelpGenerator.for_syntax('ruby').convert(contents)
  end

  def test_triggers(irc, msg)
    arcanine = self

    for trigger in Arcanine::Trigger.all + Arcanine::AuthenticatedTrigger.all
      trigger.send :run, arcanine, irc and break if trigger.send :match, msg
    end
  end

  def connect_all
    @bot.on :all do
      puts "[#{server.name}] #{sender}: #{command} - #{params.inspect}"
    end

    arcanine = self

    @bot.on :privmsg do
      if params[0][0,1] == '#' && arcanine.monitor[server.name].include?(params[0])
        if params[1][0,1] == arcanine.trigger_char
          arcanine.test_triggers self, params[1][1..-1]
        end
      elsif params[0][0,1] != '#'
          arcanine.test_triggers self, params[1]
      end
    end

    @bot.on :ping do
      pong params[0]
    end

    for s in @servers
      @bot[s[:name]].on '001' do
        s[:channels].each { |c| join c }
      end
      @monitor[s[:name]] = s[:channels] || []
    end

    @bot.connect
  end
end
