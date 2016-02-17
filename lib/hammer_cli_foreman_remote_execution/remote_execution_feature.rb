module HammerCLIForemanRemoteExecution
  class RemoteExecutionFeature < HammerCLIForeman::Command
    resource :remote_execution_features
    desc _('Manage remote execution features')

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('ID')
        field :name, _('Name')
        field :description, _('Description')
        field :job_template_name, _('Job template name')
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field :id, _('ID')
        field :label, _('Label')
        field :name, _('Name')
        field :description, _('Description')
        field :job_template_name, _('Job template name')
        field :job_template_id, _('Job template ID')
      end

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Remote execution feature updated')
      failure_message _('Could not update the remote execution feature')

      build_options
    end

    autoload_subcommands
  end

  HammerCLI::MainCommand.subcommand 'remote-execution-feature', _('Manage remote execution features'), RemoteExecutionFeature
end
