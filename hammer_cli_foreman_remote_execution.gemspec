require File.expand_path('../lib/hammer_cli_foreman_remote_execution/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'hammer_cli_foreman_remote_execution'
  s.version       = HammerCLIForemanRemoteExecution.version.dup
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Foreman Remote Execution team']
  s.email         = ['foreman-dev@googlegroups.com']
  s.homepage      = 'https://github.com/theforeman/hammer_cli_foreman_remote_execution'
  s.license       = 'GPL-3.0-or-later'

  s.summary       = 'CLI for the Foreman remote execution plugin'
  s.description   = 'CLI for the Foreman remote execution plugin'

  s.files =            `git ls-files`.split("\n")
  s.test_files =       `git ls-files test`.split("\n")
  s.extra_rdoc_files = `git ls-files doc`.split("\n") + Dir['README*', 'LICENSE']

  s.add_dependency 'hammer_cli_foreman', '>= 0.1.3', '< 4.0.0'
  s.add_dependency 'hammer_cli_foreman_tasks', '~> 0.0.3'

  s.required_ruby_version = '>= 2.7', '< 4'
end
