ENV['TEST_API_VERSION'] = '1.10'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution'

describe HammerCLIForemanRemoteExecution::JobInvocation do
  include CommandTestHelper

  context 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::ListCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'no arguments'
      it_should_accept_search_params
    end

    context 'output' do
      let(:expected_record_count) { cmd.resource.call(:index)['results'].length }
      it_should_print_n_records
      it_should_print_columns ['Id', 'Name', 'Task State']
    end
  end

  context 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::InfoCommand.new('', ctx) }

    before :each do
      cmd.stubs(:get_parameters).returns([])
    end

    context 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    context 'output' do
      with_params ['--id=1'] do
        it_should_print_columns ['Id', 'Name', 'Task State', 'Hosts']
      end
    end
  end

  context 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::CreateCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'create options', ['--job-category=Run Command','--inputs=command=foo', '--search-query=name ~ example', '--async']
    end
  end
end
