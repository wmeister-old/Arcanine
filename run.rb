#!/usr/bin/env ruby
require 'rubygems'
require 'arcanine'
require 'arcanine/config'
require 'arcanine/helpgenerator'

arcanine = Arcanine.new(Arcanine::Config.new.to_h)
arcanine.connect_all

