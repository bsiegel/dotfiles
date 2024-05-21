#!/usr/bin/env ruby

require 'yaml'

config = YAML.load(`#{__dir__}/displayplacer yaml`)
first = config['screens'][0]['id']['contextual']
second = config['screens'][1]['id']['contextual']

exec("#{__dir__}/displayplacer \"id:#{second} origin:(0,0)\" \"id:#{first} origin:(-2560,0)\"")
