require 'bundler/gem_tasks'
require 'rake/testtask'
require 'ci/reporter/rake/minitest'

Rake::TestTask.new :test do |t|
  t.libs.push "lib"
  t.test_files = Dir.glob('test/**/*_test.rb')
  t.verbose = true
end

namespace :pkg do
  desc 'Generate package source gem'
  task :generate_source => :build
end

task :default => :test

require "hammer_cli_foreman_remote_execution/version"
require "hammer_cli_foreman_remote_execution/i18n"
require "hammer_cli/i18n/find_task"
HammerCLI::I18n::FindTask.define(HammerCLIForemanRemoteExecution::I18n::LocaleDomain.new,
  HammerCLIForemanRemoteExecution.version.to_s)
