# frozen_string_literal: true

module HammerCLIForemanRemoteExecution
  class TemplateInput < HammerCLIForeman::Command
    resource :template_inputs
    desc _('Manage template inputs')

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('ID')
        field :name, _('Name')
        field :input_type, _('Input type')
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field :id, _('ID')
        field :name, _('Name')
        field :input_type, _('Input type')

        field :fact_name, _('Fact name')
        field :variable_name, _('Variable name')
        field :puppet_parameter_name, _('Puppet parameter name')
        field :options, _('Options'), Fields::List, :width => 25, :hide_blank => true
        field :default, _('Default value')
      end

      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Template input created.')
      failure_message _('Could not create the template input')

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Template input updated.')
      failure_message _('Could not update the template input')

      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Template input deleted.')
      failure_message _('Could not delete the template input')

      build_options
    end

    autoload_subcommands
  end

  HammerCLI::MainCommand.subcommand 'template-input', _('Manage template inputs'), TemplateInput
end
