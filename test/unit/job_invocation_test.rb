# frozen_string_literal: true

ENV['TEST_API_VERSION'] = '1.17'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution'

describe HammerCLIForemanRemoteExecution::JobInvocation do
  include CommandTestHelper

  describe 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::ListCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'no arguments'
      it_should_accept_search_params
    end

    describe 'output' do
      let(:expected_record_count) { cmd.resource.call(:index)['results'].length }
      it_should_print_n_records
      it_should_print_columns ['ID', 'Description', 'Status', 'Success', 'Failed', 'Pending', 'Total', 'Start']
    end
  end

  describe 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::InfoCommand.new('', ctx) }

    before :each do
      cmd.stubs(:get_parameters).returns([])
    end

    describe 'parameters' do
      it_should_accept 'id', ['--id=1']

      it 'should not accept name' do
        _out, _err = capture_io do
          _(cmd.run(%w[--name foobar])).must_equal HammerCLI::EX_USAGE
        end
      end
    end

    describe 'output' do
      with_params ['--id=1'] do
        it_should_print_columns ['ID', 'Description', 'Status', 'Success', 'Failed', 'Pending', 'Total', 'Start',
                                 'Job Category', 'Mode', 'Cron line', 'Recurring logic ID', 'Hosts', 'Randomized ordering']
      end
    end
  end

  describe 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::CreateCommand.new('', ctx) }

    describe 'parameters' do
      it 'detects async flag correctly' do
        refute cmd.option_async?
        _out, err = capture_io do
          _(cmd.run(['--job-template="Run Command - SSH Default', '--inputs=command="hostname"',
                   '--search-query="name ~ foreman"', '--start-at="2099-01-01 12:00"', '--async'])).must_equal HammerCLI::EX_OK
        end
        _(err).must_be :empty?
        assert cmd.option_async?
      end
    end
  end

  describe 'Cancel Command' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::CancelCommand.new('', ctx) }

    it_should_accept 'cancel options', ['--id=1', '--force=yes']

    it 'should not accept name' do
      _out, _err = capture_io do
        _(cmd.run(%w[--name foobar])).must_equal HammerCLI::EX_USAGE
      end
    end
  end

  describe 'RerunCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::JobInvocation::RerunCommand.new('', ctx) }

    it_should_accept 'rerun options', ['--id=1', '--failed-only=false']

    it 'should not accept name' do
      _out, _err = capture_io do
        _(cmd.run(%w[--name foobar])).must_equal HammerCLI::EX_USAGE
      end
    end
  end
end
