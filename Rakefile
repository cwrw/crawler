require "rspec/core/rake_task"
require "rubocop/rake_task"
import "./lib/tasks/generate_sitemap.rake"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: [:spec, :rubocop]
