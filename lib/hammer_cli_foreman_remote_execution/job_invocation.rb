module HammerCLIForemanRemoteExecution
  class JobInvocation < HammerCLIForeman::Command
    resource :job_invocations

    module WithoutNameOption
      def create_option_builder
        HammerCLI::Apipie::OptionBuilder.new(resource, resource.action(action), :require_options => false)
      end
    end

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('ID')
        field :description, _('Description')
        field :status_label, _('Status')
        field :succeeded, _('Success')
        field :failed, _('Failed')
        field :pending, _('Pending')
        field :total, _('Total')
        field :start_at, _('Start')
      end

      def extend_data(invocation)
        JobInvocation.extend_data(invocation)
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      extend WithoutNameOption
      output ListCommand.output_definition do
        field :job_category, _('Job Category')
        field :mode, _('Mode')
        field :cron_line, _('Cron line')
        field :recurring_logic_id, _('Recurring logic ID')
        field :hosts, _('Hosts')
      end

      def extend_data(invocation)
        JobInvocation.extend_data(invocation)
      end

      build_options do |o|
        o.expand(:none)
      end
    end

    class OutputCommand < HammerCLIForeman::Command
      action :output
      command_name 'output'
      desc _('View the output for a host')

      option '--async', :flag, N_('Do not wait for job to complete, shows current output only')

      def print_data(output)
        line_set = output['output'].sort_by { |lines| lines['timestamp'].to_f }
        since = nil

        line_set.each do |line|
          puts line['output']
          since = line['timestamp']
        end

        if output['refresh'] && !option_async?
          sleep 1
          print_data(resource.call(action, request_params.merge(:since => since), request_headers, request_options))
        end
      end

      build_options do |o|
        o.expand(:all).except(:job_invocations)
        o.without(:since)
      end
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      include HammerCLIForemanTasks::Async

      success_message _('Job invocation %{id} created')

      # Scheduling
      option '--start-at', 'DATETIME', N_('Schedule the execution for a later time'),
        :format => HammerCLI::Options::Normalizers::DateTime.new, :allow_nil => true

      option '--start-before', 'DATETIME', N_('Execution should be cancelled if it cannot be started before --start-at'),
        :format => HammerCLI::Options::Normalizers::DateTime.new, :allow_nil => true

      # Recurrence
      option '--cron-line', 'CRONLINE', N_('Create a recurring execution'),
        :format => HammerCLIForemanRemoteExecution::Options::Normalizers::CronLine.new
      option '--end-time', 'DATETIME', N_('Perform no more executions after this time, used with --cron-line'),
        :format => HammerCLI::Options::Normalizers::DateTime.new

      # Inputs
      option '--inputs', 'INPUTS', N_('Specify inputs from command line'),
        :format => HammerCLI::Options::Normalizers::KeyValueList.new

      # For passing larger scripts, etc.
      option '--input-files', 'INPUT FILES', N_('Read input values from files'),
        :format => ::HammerCLIForemanRemoteExecution::Options::Normalizers::KeyFileList.new

      option '--dynamic', :flag, N_('Dynamic search queries are evaluated at run time')

      def request_params
        params = super

        cli_inputs = option_inputs || {}
        file_inputs = option_input_files || {}
        params['job_invocation']['inputs'] = cli_inputs.merge(file_inputs)

        params['job_invocation']['targeting_type'] = option_dynamic? ? 'dynamic_query' : 'static_query'
        params
      end

      def task_progress(task_or_id)
        print_message(success_message, task_or_id)
        task = task_or_id['dynflow_task']['id']
        super(task)
      end

      alias original_option_async? option_async?

      def option_async?
        if immediate?
          original_option_async?
        else
          true
        end
      end

      def immediate?
        !(option_start_at || option_cron_line)
      end

      build_options do |o|
        o.without(:targeting_type)
      end
    end

    class CancelCommand < HammerCLIForeman::Command
      extend WithoutNameOption

      action :cancel
      command_name 'cancel'
      desc _('Cancel the job')
      success_message _('Job invocation %{id} cancelled')
      failure_message _('Could not cancel the job invocation')

      build_options { |o| o.expand(:none) }
    end

    class RerunCommand < HammerCLIForeman::CreateCommand
      extend WithoutNameOption

      action :rerun
      command_name 'rerun'
      desc _('Rerun the job')
      success_message _('Job invocation was rerun as %{id}')

      build_options { |o| o.expand(:none) }
    end

    def self.extend_data(invocation)
      if invocation['targeting'] && invocation['targeting']['hosts']
        invocation['hosts'] = "\n" + invocation['targeting']['hosts'].map { |host| " - #{host['name']}" }.join("\n")
      end

      if invocation['recurrence']
        invocation['cron_line'] = invocation['recurrence']['cron_line']
        invocation['recurring_logic_id'] = invocation['recurrence']['id']
      end

      invocation
    end

    autoload_subcommands
  end

  HammerCLI::MainCommand.subcommand 'job-invocation', _('Manage job invocations'), JobInvocation
end
