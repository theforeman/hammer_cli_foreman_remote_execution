require 'hammer_cli'
require 'hammer_cli_foreman'
require 'hammer_cli_foreman_tasks'

module HammerCLIForemanRemoteExecution
  require 'hammer_cli_foreman_remote_execution/options/normalizers'
  require 'hammer_cli_foreman_remote_execution/job_invocation'
  require 'hammer_cli_foreman_remote_execution/job_template'
  require 'hammer_cli_foreman_remote_execution/template_input'
  require 'hammer_cli_foreman_remote_execution/foreign_input_set'
  require 'hammer_cli_foreman_remote_execution/remote_execution_feature'

  def self.exception_handler_class
    HammerCLIForeman::ExceptionHandler
  end
end
