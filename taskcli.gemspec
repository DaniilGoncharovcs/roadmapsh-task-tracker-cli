# frozen_string_literal: true

require_relative 'lib/taskcli'

Gem::Specification.new 'taskcli' do |spec|
  spec.version = TaskCLI::VERSION
  spec.authors = ['Goncharov Daniil']
  spec.description = spec.summary = 'Task Tracker CLI. The idea for this project was taken from (roadmap.sh)https://roadmap.sh/projects/task-tracker'

  spec.required_ruby_version = '3.3.6'
  spec.files = Dir['bin/**/*', 'lib/**/*']
  
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^bin/task-cli}) {|f| File.basename(f)}
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.2.1'
  spec.add_development_dependency 'rubocop'
end
