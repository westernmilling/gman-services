require 'rake'
require 'rspec/core/rake_task'
require 'rubocop'
require 'rubocop/rake_task'

task :spec do
  Rake::Task['rspec'].invoke
  Rake::Task['rubocop'].invoke
  # Rake::Task['pronto'].invoke
end

RSpec::Core::RakeTask.new(:rspec) do |tsk|
  tsk.rspec_opts = '--format p'
  # t.rspec_opts = '--format documentation'
end

RuboCop::RakeTask.new(:rubocop) do |_tsk|
  # t.rspec_opts = '--format documentation'
end
