# frozen_string_literal: true

module TaskCLI
  # Parse console arguments
  class ConsoleHandler
    attr_reader :result

    VALID_COMMANDS = %w[add update delete mark-in-progress mark-done list].freeze
    LIST_STATUSES = %w[all done todo in-progress].freeze

    def initialize
      @command, *@args = ARGV.map(&:strip)
      @result = nil
    end

    def run
      handle_invalid_command unless VALID_COMMANDS.include?(@command)
      process_command
      @result
    end

    private

    def process_command
      if mark_command?
        handle_mark
      elsif valid_command?
        execute_command
      else
        handle_invalid_command
      end
    end

    def mark_command?
      @command.include?('mark')
    end

    def valid_command?
      command_handlers.key?(@command)
    end

    def execute_command
      @result = command_handlers[@command].call
    end

    def command_handlers
      {
        'add' => method(:handle_add),
        'update' => method(:handle_update),
        'delete' => method(:handle_delete),
        'list' => method(:handle_list)
      }
    end

    def handle_add
      handle_error('add', 'No task description provided') if @args.empty?
      [@command, @args.join(' ')]
    end

    def handle_update
      task_id = extract_task_id || return
      task_description = @args.join(' ')
      handle_error('update', 'No new task description provided') if task_description.empty?
      [@command, task_id, task_description]
    end

    def handle_delete
      task_id = extract_task_id || return
      [@command, task_id]
    end

    def handle_mark
      task_id = extract_task_id || return
      [@command, task_id]
    end

    def handle_list
      handle_error('list', 'Invalid or missing status') unless LIST_STATUSES.include?(@args[0])
      [@command, @args[0]]
    end

    def extract_task_id
      Integer(@args.shift)
    rescue ArgumentError, TypeError
      handle_error(@command, 'Invalid task ID')
      nil
    end

    def handle_invalid_command
      puts 'Please use one of these commands:'
      show_help
      exit
    end

    def handle_error(command, message)
      puts "Error: #{message}"
      send("show_#{command}")
      exit
    end

    def show_help
      show_add
      show_update
      show_delete
      show_mark
      show_list
    end

    def show_add
      puts '# add - Adding a new task'
      puts 'task-cli add Buy groceries'
    end

    def show_update
      puts '# update - Update task by task id<integer>'
      puts 'task-cli update 1 Buy groceries and cook dinner'
    end

    def show_delete
      puts '# delete - Delete task by id'
      puts 'task-cli delete 1'
    end

    def show_mark
      puts '# mark-<status> - Mark task as in progress or done'
      puts 'task-cli mark-in-progress 1'
      puts 'task-cli mark-done 1'
    end

    def show_list
      puts '# list <status> - Listing all tasks by status'
      puts 'task-cli list'
      puts 'task-cli list done'
      puts 'task-cli list todo'
      puts 'task-cli list in-progress'
    end
  end
end
