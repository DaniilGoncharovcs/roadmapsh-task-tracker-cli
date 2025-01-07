# roadmapsh-task-tracker-cli

Task tracker is a project used to track and manage your tasks.
In this task, you will build a simple command line interface (CLI)
to track what you need to do, what you have done,
and what you are currently working on.
The idea for the project taken from [roadmap.sh](https://roadmap.sh/projects/task-tracker).

## Usage

```sh
./task-cli # run as executable

bundler exec task-cli # run executable via bundler
```

> To run you must have Ruby installed.

Running without arguments will display a description of
all available commands and examples of use.

### Supported Commands

- `list <todo|in-progress|done>` - Displays a list of all tasks.
- `add <description>` - Adds a new task with <description>.
- `update <id> <description>` - Updates the task description
- `mark-<in-progress|done>` - Updates task status and saves to a json file.
- `delete <id>` - Delete the task by id.
