# frozen_string_literal: true

# Console methods
module Console
  USAGE_LINES = [
    'USAGE:',
    "\tlist <todo|in-progress|done> - Displays a list of all tasks.
    If no argument with status is passwd, then displays all tasks.",
    "\tadd <description> - Adds a new task with <description>.
    Save new task in tasks directory with name task_<id>.json.",
    "\tupdate <id> <description> - Updates the task description
    with <id> and saves to a json file.",
    "\tmark-<in-progress|done> - Updates task status and saves to a json file.",
    "\tdelete <id> - Delete the task by id.",
    'EXAMPLES:',
    "\tlist:",
    "\t\t./task-cli list                # show all tasks",
    "\t\t./task-cli list todo           # show tasks with todo status",
    "\t\t./task-cli list in-progress    # show tasks with in-progress status",
    "\t\t./task-cli list done           # show tasks with done status",
    "\tadd:",
    "\t\t./task-cli add clean the house",
    "\t\t./task-cli add walk the dog",
    "\tupdate:",
    "\t\t./task-cli update 1 walk the dog",
    "\t\t./task-cli update 2 clean the house",
    "\tmark-:",
    "\t\t./task-cli mark-in-progress 1",
    "\t\t./task-cli mark-done 2",
    "\tdelete:",
    "\t\t./task-cli delete 1"
  ].freeze

  HEADER_TEMPLATE = '| %<id>-2s | %<description>-20s | %<status>-15s | %<updated>-20s | %<created>-20s |'
  LINE_WIDTH = 93

  def self.usage
    USAGE_LINES.each { |line| puts line }
  end

  def self.print(tasks)
    puts formated_tasklist(tasks)
  end

  def self.formated_tasklist(tasks)
    lines = [divider, header, divider]
    tasks.each { |task| lines << format_task(task) }
    lines << divider
    lines.join("\n")
  end

  def self.divider
    '-' * LINE_WIDTH
  end

  def self.header
    format(
      HEADER_TEMPLATE,
      id: 'Id', description: 'Description', status: 'Status', updated: 'Updated', created: 'Created'
    )
  end

  def self.format_task(task)
    format(
      HEADER_TEMPLATE,
      id: task.id, description: task.description, status: task.status, updated: task.updated, created: task.created
    )
  end
end
