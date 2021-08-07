# frozen_string_literal: true

require_relative "lib/la_poste"

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc "Read transactions from file(\"input.txt\" by default) and log output to STDOUT"
task :run, [:filename] do |_task, args|
  controller = LaPoste::Controller.new
  controller.from_file_to_stdout(args[:filename] || "input.txt")
end
