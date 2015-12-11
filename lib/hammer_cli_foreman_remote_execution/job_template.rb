module HammerCLIForemanRemoteExecution
  class JobTemplate < HammerCLIForeman::Command
    resource :job_templates

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :job_name, _('Job Name')
        field :provider_type, _('Provider')
        field :type, _('Type')
      end

      def extend_data(template)
        JobTemplate.data_extensions(template)
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output ListCommand.output_definition do
        field :template_inputs, _('Inputs')
        HammerCLIForeman::References.taxonomies(self)
      end

      def extend_data(template)
        JobTemplate.data_extensions(template)
      end

      build_options
    end

    class DumpCommand < HammerCLIForeman::InfoCommand
      command_name 'dump'
      desc _('View job template content')

      def print_data(template)
        puts template['template']
      end

      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      option '--file', 'TEMPLATE', N_('Path to a file that contains the template'),
             :attribute_name => :option_template, :required => true,
             :format => HammerCLI::Options::Normalizers::File.new

      success_message _('Job template created')
      failure_message _('Could not create the job template')

      build_options do |o|
        o.without(:template)
      end
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      option '--file', 'TEMPLATE', N_('Path to a file that contains the template'),
             :attribute_name => :option_template,
             :format => HammerCLI::Options::Normalizers::File.new

      success_message _('Job template updated')
      failure_message _('Could not update the job template')

      build_options do |o|
        o.without(:template)
      end
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Job template deleted')
      failure_message _('Could not delete the job template')

      build_options
    end

    def self.data_extensions(template)
      template['type'] = template['snippet'] ? 'snippet' : 'job_template'

      if template['template_inputs']
        template_inputs = template['template_inputs'].map { |option| "  - #{option['name']}" }.join("\n")
        template['template_inputs'] = "\n#{template_inputs}\n"
      end

      template
    end

    autoload_subcommands
  end

  HammerCLI::MainCommand.subcommand 'job-template', _('Manage job templates'), JobTemplate
end
