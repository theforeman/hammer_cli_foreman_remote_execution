require 'bundler/gem_tasks'
require 'rake/testtask'
require 'ci/reporter/rake/minitest'

Rake::TestTask.new :test do |t|
  t.libs.push "lib"
  t.test_files = Dir.glob('test/**/*_test.rb')
  t.verbose = true
end

namespace :gettext do

  task :setup do
    require "hammer_cli_foreman_remote_execution/version"
    require "hammer_cli_foreman_remote_execution/i18n"
    require 'gettext/tools/task'

    domain = HammerCLIForemanRemoteExecution::I18n::LocaleDomain.new
    GetText::Tools::Task.define do |task|
      task.package_name = domain.domain_name
      task.package_version = HammerCLIForemanRemoteExecution.version.to_s
      task.domain = domain.domain_name
      task.mo_base_directory = domain.locale_dir
      task.po_base_directory = domain.locale_dir
      task.files = domain.translated_files
    end
  end

  desc "Update pot file"
  task :find => [:setup] do
    Rake::Task["gettext:po:update"].invoke
  end

end

namespace :pkg do
  desc 'Generate package source gem'
  task :generate_source => :build
end

task :default => :test
