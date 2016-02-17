ENV['TEST_API_VERSION'] = '1.10'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution/remote_execution_feature'

describe HammerCLIForemanRemoteExecution::RemoteExecutionFeature do
  include CommandTestHelper

  context 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::RemoteExecutionFeature::ListCommand.new('', ctx) }

    context 'output' do
      with_params [] do
        let(:expected_record_count) { cmd.resource.call(:index)['results'].length }
        it_should_print_n_records
        it_should_print_columns ['ID', 'Name', 'Description', 'Job template name']
      end
    end
  end

  context 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::RemoteExecutionFeature::InfoCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'required parameters', ['--name=foo']
    end

    context 'output' do
      with_params ['--id=1'] do
        it_should_print_columns ['ID', 'Label', 'Name', 'Description', 'Job template ID', 'Job template name']
      end
    end
  end


  context 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::RemoteExecutionFeature::UpdateCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'create options', ['--name=feature', "--job-template=asdf"]
    end
  end
end
