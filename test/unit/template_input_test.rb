# frozen_string_literal: true

ENV['TEST_API_VERSION'] = '1.17'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution/template_input'

describe HammerCLIForemanRemoteExecution::TemplateInput do
  include CommandTestHelper

  describe 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::ListCommand.new('', ctx) }

    describe 'output' do
      with_params ['--template-id=1'] do
        let(:expected_record_count) { cmd.resource.call(:index, :template_id => 1)['results'].length }
        it_should_print_n_records
        it_should_print_columns ['ID', 'Name', 'Input type']
      end
    end
  end

  describe 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::InfoCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'required parameters', ['--template-id=template', '--name=foo']
    end

    describe 'output' do
      with_params ['--template-id=1', '--id=1'] do
        it_should_print_columns ['ID', 'Name', 'Input type', 'Fact name', 'Variable name', 'Puppet parameter name']
      end
    end
  end

  describe 'DeleteCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::DeleteCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'required parameters', ['--template-id=template', '--name=foo']
    end
  end

  describe 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::CreateCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'create options', ['--template-id=1', "--name=asdf", '--input-type=user']
    end
  end

  describe 'UpdateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::UpdateCommand.new('', ctx) }

    describe 'parameters' do
      it_should_accept 'update options', ['--template-id=1', '--name=asdf', '--input-type=user', '--new-name=fdsa']
    end
  end
end
