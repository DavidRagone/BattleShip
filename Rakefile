require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/lib/*'
end

task :default => :spec
task :test => :spec
