ENV['TEST_API_VERSION'] = '1.17'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution/job_template'

describe HammerCLIForemanRemoteExecution::JobTemplate do
  include CommandTestHelper

  describe 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::ListCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'no arguments'
      it_should_accept_search_params
    end

    describe 'output' do
      let(:expected_record_count) { cmd.resource.call(:index)['results'].length }
      it_should_print_n_records
      it_should_print_columns ['ID', 'Name', 'Job Category', 'Provider', 'Type']
    end
  end

  describe 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::InfoCommand.new('', ctx) }

    before :each do
      cmd.stubs(:get_parameters).returns([])
    end

    describe 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    describe 'output' do
      with_params ['--id=1'] do
        it_should_print_columns ['ID', 'Name', 'Job Category', 'Provider', 'Type']
      end
    end
  end

  describe 'DumpCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::DumpCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    describe 'output' do
      it 'must dump template' do
        cmd.stubs(:context).returns(ctx.update(:adapter => :test))
        out, _err = capture_io do
          cmd.run(['--id=1'])
        end
        out.must_match(/id/)
      end
    end
  end

  describe 'ImportCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::ImportCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'import options',
        ["--file=#{File.join(File.dirname(__FILE__), '..', 'data', 'export.erb')}", '--overwrite=false']
    end
  end

  describe 'ExportCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::ExportCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'id', ['--id=1']
      it_should_accept 'name', ['--name=template']
    end

    describe 'output' do
      it 'must export template' do
        cmd.stubs(:context).returns(ctx.update(:adapter => :test))
        out, _err = capture_io do
          cmd.run(['--id=1'])
        end
        out.must_match(/id/)
      end
    end
  end

  describe 'DeleteCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::DeleteCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'name', ['--name=template']
      it_should_accept 'id', ['--id=1']
    end
  end

  describe 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobTemplate::CreateCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'create options',
        ['--name=Test', "--file=#{File.join(File.dirname(__FILE__), '..', 'data', 'template.txt')}", '--job-category=Install',
         '--provider-type=SSH']
    end
  end
end
