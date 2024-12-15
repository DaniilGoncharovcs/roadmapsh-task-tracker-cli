# frozen_string_literal: true

require 'optparse'
require_relative 'taskcli/console_handler'

# Task CLI module
module TaskCLI
  VERSION = '0.0.1'

  def self.start
    console_handler_result = TaskCLI::ConsoleHandler.new.run

    puts console_handler_result
  end
end
