class Arcanine::Trigger
	@@triggers = []

  def self.inherited(subclass)
    @@triggers << subclass
  end

	def self.triggers
		@@triggers
	end

  def self.regex
    raise 'Override me!'
  end

  def self.match(msg)
    @@matches =  self.regex.match msg
    msg       =~ self.regex
  end

  def self.run(irc)
    action(irc, *@@matches[1..-1])
  end

  def self.action
    raise 'Override me!'
  end
end

