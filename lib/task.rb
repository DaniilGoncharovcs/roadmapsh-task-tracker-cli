# frozen_string_literal: true

require 'time'
require_relative 'jsonable'

# The Task class
class Task
  include Jsonable

  STATUSES = %w[todo in-progress done].freeze

  attr_reader :id, :description, :status, :created, :updated

  def id=(value)
    raise 'ID must be a integer' unless Integer.try_convert(value)

    @id = value
  end

  def description=(value)
    raise 'Description must not be empty' unless value

    @description = value
  end

  def status=(value)
    raise 'Unsupported task status' unless STATUSES.include?(value)

    @status = value
  end

  def updated=(value)
    raise 'Updated time must not be empty' unless value

    @updated = value
  end

  def initialize(id, description, task_data = {})
    self.id = id
    self.description = description
    self.status = task_data['status'] || 'todo'
    self.updated = task_data['updated'] || Time.new.strftime('%Y-%m-%d %H:%M:%S')
    @created = task_data['created'] || Time.new.strftime('%Y-%m-%d %H:%M:%S')
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete('@')] = instance_variable_get(var)
    end
    hash
  end
end
