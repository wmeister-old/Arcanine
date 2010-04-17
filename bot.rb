#!/usr/bin/env ruby
require 'rubygems'
require 'on_irc'
require 'syntax'
require 'bot-help.rb'

$trigger_char = '@'
$triggers     = []
$help         = HelpGenerator.for_syntax('ruby').convert(File.read('bot-eval.rb'))

bot = IRC.new do
  nick     'Arcanine'
  ident    'Arcanine'
  realname 'pokebot1986'

  server :freenode do
    address 'irc.freenode.net'
  end
end

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

bot.on :all do
  puts "#{sender}: #{command} #{params.inspect}"
end

bot.on :ping do
  pong params[0]
end

bot.connect
