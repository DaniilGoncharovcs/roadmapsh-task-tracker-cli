# frozen_string_literal: true

require 'fileutils'
require 'json'
require_relative 'task'

# Contains serialize and deserialize task object
module Jsonable
  def serialize
    FileUtils.mkdir_p('tasks')

    File.open("tasks/task_#{@id}.json", 'w') do |f|
      f.write(JSON.pretty_generate(to_hash))
    end
  end

  def delete
    filename = "tasks/task_#{@id}.json"
    raise "Can't find #{filename} file" unless File.exist?(filename)

    File.delete(filename)
  end

  def self.deserialize(filename)
    raise "Can't find #{filename} file" unless File.exist?(filename)

    file = File.read(filename)

    json = JSON.parse(file)

    Task.new(json['id'], json['description'], json)
  end
end
