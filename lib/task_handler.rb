# frozen_string_literal: true

require_relative 'task'
require_relative 'jsonable'

# CRUD Task operation handler
class TaskHandler
  attr_reader :task_list

  def task_list=(value)
    raise 'Can\'t load tasks' unless value

    @task_list = value.sort_by!(&:id)
  end

  def initialize
    self.task_list = load_tasks
  end

  def load_tasks
    task_list = []

    Dir['tasks/task_[0-9]*.json'].each do |path|
      process_task(path, task_list)
    end

    task_list
  end

  def process_task(path, task_list)
    loaded_task = Jsonable.deserialize(path)
    existing_task_index = task_list.index { |task| task.id == loaded_task.id }

    if existing_task_index
      task_list[existing_task_index] = loaded_task
    else
      task_list << loaded_task
    end
  end

  def list(status = nil)
    return task_list unless status

    task_list.find_all do |task|
      task.status == status
    end
  end

  def add(description)
    task = Task.new(
      @task_list.length + 1,
      description
    )

    task.serialize
  end

  def update_task(id)
    task = search_by_id(id)
    yield(task) if block_given?

    task.updated = Time.new.strftime('%Y-%m-%d %H:%M:%S')
    task.serialize
  end

  def update(id, description)
    update_task(id) { |task| task.description = description }
  end

  def mark(id, status)
    update_task(id) { |task| task.status = status }
  end

  def delete(id)
    search_by_id(id).delete
  end

  def search_by_id(id)
    raise 'ID must be an Integer' unless id || Integer.try_convert(id)

    existing_task = task_list.find { |task| task.id == id.to_i }

    raise "Can't find task with id: #{id}" unless existing_task

    existing_task
  end
end
