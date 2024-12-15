# Task Tracker CLI

This repository containes an implementation of a Task Tracker CLI. The idea for this project was taken from (roadmap.sh)[https://roadmap.sh/projects/task-tracker]. I tried to write this program using only the standart Ruby library.

## Description

Call without arguments return description of each command:

```sh
./task-cli
```

### Supported commands:

- `./task-cli add description` - Create a new Task with a description and saves as json file in `json_tasks/`
- `./task-cli update 1` - Update old task and overried old task file
- `./task-cli delete 1` - Removes task file
- `./task-cli list all|todo|in-progress|done` - Prints a list of tasks using a filter
- `./task-cli mark-in-progress|mark-done 1` - Update task status
