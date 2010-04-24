class Arcanine
  class Trigger
    @@triggers = []
    @@help = nil

    def self.inherited(subclass)
      @@triggers << subclass if subclass != AuthenticatedTrigger
    end

    def self.all
      @@triggers
    end

    def self.help(help = nil)
      unless help.nil?
        @@help = help
      end
      @@help
    end

    def self.regex
      raise 'Override me!'
    end

    def self.match(msg)
      @@matches =  self.regex.match msg
      msg       =~ self.regex
    end

    def self.run(arcanine, irc)
      begin
        action(arcanine, irc, *@@matches[1..-1])
      rescue Exception => e
        irc.respond "Error in trigger #{self}: #{e.message} - #{e.backtrace.join '; '}" 
      end
    end

    def self.action
      raise 'Override me!'
    end
  end
end
