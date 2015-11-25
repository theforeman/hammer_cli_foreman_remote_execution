ENV['TEST_API_VERSION'] = '1.10'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution/job_template'

describe HammerCLIForemanRemoteExecution::JobTemplate do
  include CommandTestHelper

  context 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::ListCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'no arguments'
      it_should_accept_search_params
    end

    context 'output' do
      let(:expected_record_count) { cmd.resource.call(:index)['results'].length }
      it_should_print_n_records
      it_should_print_columns ['Id', 'Name', 'Job Name', 'Provider', 'Type']
    end
  end

  context 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::InfoCommand.new('', ctx) }

    before :each do
      cmd.stubs(:get_parameters).returns([])
    end

    context 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    context 'output' do
      with_params ['--id=1'] do
        it_should_print_columns ['Id', 'Name', 'Job Name', 'Provider', 'Type']
      end
    end
  end

  context 'DumpCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::DumpCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    context 'output' do
      it 'must dump template' do
        cmd.stubs(:context).returns(ctx.update(:adapter => :test))
        out, _err = capture_io do
          cmd.run(['--id=1'])
        end
        out.must_match(/id/)
      end
    end
  end

  context 'DeleteCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::DeleteCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'name', ['--name=template']
      it_should_accept 'id', ['--id=1']
    end
  end

  context 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::CreateCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'create options', ['--name=Test', "--file=#{File.join(File.dirname(__FILE__), 'data', 'template.txt')}", '--job-name=Install', '--provider-type=Ssh']
    end
  end
end
