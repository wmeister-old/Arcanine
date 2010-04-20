class Arcanine
  class Trigger
    @@triggers = []
    @@help = nil

    def self.inherited(subclass)
      @@triggers << subclass
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
      action(arcanine, irc, *@@matches[1..-1])
    end

    def self.action
      raise 'Override me!'
    end
  end
end
