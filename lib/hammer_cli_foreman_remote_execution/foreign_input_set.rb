module HammerCLIForemanRemoteExecution
  class ForeignInputSet < HammerCLIForeman::Command
    resource :foreign_input_sets
    desc _('Manage foreign input sets')

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :target_template_id, _('Target template id')
        field :target_template_name, _('Target template name')
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :target_template_id, _('Target template id')
        field :target_template_name, _('Target template name')
        field :include_all, _('Include all')
        field :include, _('Include')
        field :exclude, _('Exclude')
      end

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Foreign input set updated')
      failure_message _('Could not update the input set')

      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Foreign input set created')
      failure_message _('Could not create the input set')

      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Foreign input set deleted')
      failure_message _('Could not delete the input set')

      build_options
    end

    autoload_subcommands
  end

  HammerCLI::MainCommand.subcommand 'foreign-input-set', _('Manage foreign input sets'), ForeignInputSet
end
