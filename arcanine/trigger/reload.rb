class Arcanine::Trigger::Reload < Arcanine::Trigger

=begin
  command: reload
  description: reloads trigger sub classes
=end

  def self.regex
    /^reload\s*$/i
  end

  def self.action(arcanine, irc)
    old_triggers = Arcanine::Trigger.all.length
    arcanine.load_triggers
    cur_triggers = Arcanine::Trigger.all.length
    new_triggers = cur_triggers - old_triggers

    irc.respond "Trigger Reload Completed - Total: #{cur_triggers}; New: #{new_triggers}"
  end
end

