module Yobot
  module Behaviors
  end
end

$LOAD_PATH.unshift File.dirname(__FILE__)

require "rubygems"
require "bundler/setup"

require 'firering'
require 'json'
require 'yobot/bot'
Dir[File.dirname(__FILE__) + '/yobot/behaviors/*.rb'].each do |behavior|
  require behavior
end