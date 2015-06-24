require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color -fd spec/lita'
end

task default: :spec

# Style tests (Rubocop)
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new :ruby
end

# Run all style tasks
desc 'Run all style checks'
task style: ['style:ruby']
