class Arcanine
  class AuthenticatedTrigger < Trigger
    def self.inherited(subclass)
      @@triggers << subclass
    end

    def self.run(arcanine, irc)
      super arcanine, irc if arcanine.authenticated irc.sender
    end
  end
end
