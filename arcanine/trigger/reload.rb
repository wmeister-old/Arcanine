class Arcanine::Trigger::Reload < Arcanine::Trigger
  def self.regex
    /^reload\s*$/i
  end

  def self.action(arcanine, irc)
    old_triggers = Arcanine::Trigger.all
    arcanine.load_triggers
    cur_triggers = Arcanine::Trigger.all

    removed_triggers = 0
    new_triggers     = 0

    cur_triggers.each { |t| new_triggers += 1 unless old_triggers.include? t }
    old_triggers.each { |t| removed_triggers += 1 unless cur_triggers.include? t }

    irc.respond "Trigger Reload Completed - Total: #{cur_triggers.length}; New: #{new_triggers}; Removed: #{removed_triggers}"
  end
end

